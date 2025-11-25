//
//  NetworkService.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

@MainActor
final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - PROPERTIES -
    
    //Normal
    private let session: URLSession
    private let decoder: JSONDecoder
    private let logger: NetworkLogger = NetworkLogger.shared
    
    // MARK: - INITIALIZER -
    init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    /// In order to decode the raw data into designated model
    /// - Parameters:
    ///   - endpoint: `Endpoint` on which API will be called
    ///   - type: `T.Type` model, on which the response will be mapped
    /// - Returns: `T` will return the data in the form of model that is provided
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let data = try await self.request(endpoint)
        
        if let base = try? self.decoder.decode(BaseResponse<T>.self, from: data) {
            if let status = base.status, status >= 400 {
                throw NetworkError.serverError(code: status, message: base.message ?? "Unknown Error")
            }
            
            if let actualData = base.data {
                return actualData
            }
        }
        
        if let direct = try? self.decoder.decode(T.self, from: data) {
            return direct
        }
        
        throw NetworkError.decodingError
    }
    
    /// In order to make a request according to the endpoint
    /// - Parameter endpoint: `Endpoint` on which api request will be created
    /// - Returns: `Data` will return the raw data after processing the request
    private func request(_ endpoint: Endpoint) async throws -> Data {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        var mergedHeaders = ["Content-Type": "application/json"]
        endpoint.headers?.forEach { mergedHeaders[$0.key] = $0.value }
        
        request.allHTTPHeaderFields = mergedHeaders
        
        if let body = endpoint.body {
            request.httpBody = body
        }
        
        if endpoint.method == .get,
           let parameters = endpoint.parameters {
            request.url = self.addQueryParameters(parameters, to: url)
        }
        
        self.logger.logRequest(request)
        
        do {
            let (data, response) = try await self.session.data(for: request)
            
            self.logger.logResponse(response, data: data, error: nil)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown(NSError())
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                if let backendError = try? self.decoder.decode(BaseErrorResponse.self, from: data) {
                    throw NetworkError.serverError(code: httpResponse.statusCode, message: backendError.message ?? "Unknown Error")
                }
                
                throw NetworkError.serverError(code: httpResponse.statusCode, message: nil)
            }
            
            return data
        } catch {
            self.logger.logResponse(nil, data: nil, error: error)
            
            if error is NetworkError {
                throw error
            }
            
            throw NetworkError.unknown(error)
        }
    }
    
    /// In order to add query params to the request URL
    /// - Parameters:
    ///   - parameters: `[String: Any]` queries that needs to be added
    ///   - url: `URL` in which query will be added
    /// - Returns: `URL?` will return a complete URL after adding the query params
    private func addQueryParameters(_ parameters: [String: Any], to url: URL) -> URL? {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        components?.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        
        return components?.url
    }
}
