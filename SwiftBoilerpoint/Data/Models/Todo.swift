//
//  Todo.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import Foundation

struct GetAllTodoResponse: Codable, Sendable {
    var todos: [Todos]?
    var total: Int?
    var skip: Int?
    var limit: Int?
}

struct Todos: Codable, Sendable {
    var id: Int?
    var todo: String?
    var completed: Bool?
    var userId: Int?
}

struct TodoDeletionResponse: Codable, Sendable {
    var id: Int?
    var todo: String?
    var completed: Bool?
    var userId: Int?
    var isDeleted: Bool?
    var deletedOn: Date?
}
