//
//  TodoRepository.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

protocol TodoRepositoryProtocol {
    func getAllTodos() async throws -> GetAllTodoResponse?
    func deleteTodo(id: Int) async throws -> TodoDeletionResponse?
}

final class TodoRepository: TodoRepositoryProtocol {
    
    // MARK: - PROPERTIES -
    
    //Normal
    private let networkService: NetworkServiceProtocol
    
    // MARK: - INITIALIZER -
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getAllTodos() async throws -> GetAllTodoResponse? {
        try await self.networkService.request(TodoEndpoint.fetchAllTodos)
    }
    
    func deleteTodo(id: Int) async throws -> TodoDeletionResponse? {
        try await self.networkService.request(TodoEndpoint.deleteTodo(id: id))
    }
}
