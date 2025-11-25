//
//  TodoEndpoint.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

enum TodoEndpoint: Endpoint {
    case fetchAllTodos
    case deleteTodo(id: Int)
    
    var baseURL: String {
        return EnvironmentManager.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchAllTodos:
            "/todos"
        case .deleteTodo(let id):
            "/todos/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchAllTodos:
            return .get
        case .deleteTodo:
            return .delete
        }
    }
}
