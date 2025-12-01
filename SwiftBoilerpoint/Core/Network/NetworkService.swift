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

final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - PROPERTIES -
    
    //Normal
    private let session: URLSession
    private let decoder: JSONDecoder
    private let logger: NetworkLogger
    
    // MARK: - INITIALIZER -
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder(), logger: NetworkLogger = NetworkLogger.shared) {
        self.session = session
        self.logger = logger
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    /// In order to decode the raw data into designated model
    /// - Parameters:
    ///   - endpoint: `Endpoint` on which API will be called
    ///   - type: `T.Type` model, on which the response will be mapped
    /// - Returns: `T` will return the data in the form of model that is provided
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let data = try await self.performRequest(endpoint)
        
        if let baseResponse = try? self.decoder.decode(BaseResponse<T>.self, from: data) {
            if let status = baseResponse.status, status >= 400 {
                throw NetworkError.serverError(code: status, message: baseResponse.message)
            }
            if let value = baseResponse.data {
                return value
            }
        }
        
        guard let result = try? self.decoder.decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
    
    /// In order to make a request according to the endpoint
    /// - Parameter endpoint: `Endpoint` on which api request will be created
    /// - Returns: `Data` will return the raw data after processing the request
    private func performRequest(_ endpoint: Endpoint) async throws -> Data {
        guard let baseURL = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        var finalURL = baseURL
        
        if endpoint.method == .get, let params = endpoint.parameters {
            finalURL = self.buildURL(baseURL, params: params)
        }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        urlRequest.allHTTPHeaderFields = self.buildHeaders(endpoint.headers)
        
        if endpoint.method != .get {
            urlRequest.httpBody = endpoint.body
        }
        
        self.logger.logRequest(urlRequest)
        
        do {
            let (data, response) = try await self.session.data(for: urlRequest)
            self.logger.logResponse(response, data: data, error: nil)
            
            guard let http = response as? HTTPURLResponse else {
                throw NetworkError.unknown(NSError())
            }
            
            guard 200...299 ~= http.statusCode else {
                if let backendError = try? self.decoder.decode(BaseErrorResponse.self, from: data) {
                    throw NetworkError.serverError(code: http.statusCode, message: backendError.message)
                }
                
                throw NetworkError.serverError(code: http.statusCode, message: nil)
            }
            
            return data
        } catch {
            self.logger.logResponse(nil, data: nil, error: error)
            
            if let networkError = error as? NetworkError {
                throw networkError
            }
            
            throw NetworkError.unknown(error)
        }
    }
    
    /// In order to build the headers in case there are any custom headers in the requested endpoint
    /// - Parameter custom: `[String: String]?` custom header which will be needed in order to merge with base header
    /// - Returns: `[String: String]` will return us the merged header
    private func buildHeaders(_ custom: [String: String]?) -> [String: String] {
        var defaultHeaders: [String: String] = [
            "Accept": "application/json"
        ]
        
        if custom != nil {
            custom?.forEach { defaultHeaders[$0.key] = $0.value }
        }
        
        return defaultHeaders
    }
    
    /// In order to build the URL for `get` method in case there are query params
    /// - Parameters:
    ///   - url: `URL` in which we will be appending the query params
    ///   - params: `[String: Any]?` params that needs to be inserted in the url request
    /// - Returns: `URL` will return us the url after adding query params
    private func buildURL(_ url: URL, params: [String: Any]?) -> URL {
        guard let params else { return url }
        
        var componenets = URLComponents(url: url, resolvingAgainstBaseURL: false)
        componenets?.queryItems = params.compactMap {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        
        return componenets?.url ?? url
    }
}
