//
//  Endpoint.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var url: URL? { return URL(string: self.baseURL + self.path) }
    var headers: [String: String]? { return nil }
    var parameters: [String: Any]? { return nil }
    var body: Data? { return nil }
}
