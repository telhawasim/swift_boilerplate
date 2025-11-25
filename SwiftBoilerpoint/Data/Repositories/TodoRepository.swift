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
        let endpoint = TodoEndpoint.fetchAllTodos
        let response: GetAllTodoResponse = try await self.networkService.request(endpoint)
        
        return response
    }
    
    func deleteTodo(id: Int) async throws -> TodoDeletionResponse? {
        let endpoint = TodoEndpoint.deleteTodo(id: id)
        let response: TodoDeletionResponse = try await self.networkService.request(endpoint)
        
        return response
    }
}
