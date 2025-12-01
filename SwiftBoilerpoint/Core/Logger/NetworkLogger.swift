//
//  NetworkLogger.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import Foundation

protocol NetworkLoggerProtocol {
    func logRequest(_ request: URLRequest)
    func logResponse(_ response: URLResponse?, data: Data?, error: Error?)
}

final class NetworkLogger: NetworkLoggerProtocol {
    
    // MARK: - PROPERTIES -
    
    //Normal
    static let shared = NetworkLogger()
    var isEnabled = true
    
    /// In order to log the request
    /// - Parameter request: `URLRequest` in order to log the headers and body
    func logRequest(_ request: URLRequest) {
        guard self.isEnabled else { return }
        
        print("\n📤 REQUEST: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        
        if let headers = request.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
    }
    
    /// In order to log the response
    /// - Parameters:
    ///   - response: `URLResponse?` in order to get the status code
    ///   - data: `Data?` in order to get the data received from the response
    ///   - error: `Error?` in order to get the error
    func logResponse(_ response: URLResponse?, data: Data?, error: Error?) {
        guard self.isEnabled else { return }
        
        if let error = error {
            print("\n❌ ERROR: \(error.localizedDescription)")
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            let statusIcon = (200...299).contains(httpResponse.statusCode) ? "✅" : "⚠️"
            print("\n\(statusIcon) RESPONSE: \(httpResponse.statusCode)")
            
            guard let data = data else { return }
            
            if let prettyString = data.prettyPrintedJSONString {
                print("Response:\n\(prettyString)")
            } else if let rawString = String(data: data, encoding: .utf8) {
                // Fallback
                print("Response:\n\(rawString)")
            }
        }
    }
}
