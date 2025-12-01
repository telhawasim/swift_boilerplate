//
//  NetworkError.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(code: Int, message: String?)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noData: return "No data received from the server"
        case .decodingError: return "Failed to decode the response"
        case .serverError(let code, let message): return "Server returned error: \(code) - \(message ?? "Unknown")"
        case .unknown(let error): return error.localizedDescription
        }
    }
}
