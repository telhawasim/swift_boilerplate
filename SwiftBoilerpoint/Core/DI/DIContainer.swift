//
//  DIContainer.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

final class DIContainer {
    
    // MARK: - PROPERTIES -
    
    static let shared = DIContainer()
    
    private init() { }
    
    lazy var networkService: NetworkServiceProtocol = {
        NetworkService()
    }()
    
    lazy var todoRepository: TodoRepositoryProtocol = {
        TodoRepository(networkService: self.networkService)
    }()
    
    func makeTodoViewModel() -> TodoView.ViewModel {
        return TodoView.ViewModel(repository: self.todoRepository)
    }
}
