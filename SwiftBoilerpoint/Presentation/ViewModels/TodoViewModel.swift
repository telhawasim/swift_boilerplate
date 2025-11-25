//
//  TodoViewModel.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import Foundation

extension TodoView {
    
    @Observable
    @MainActor
    final class ViewModel {
        
        // MARK: - PROPERTIES -
        
        //Normal
        private let repository: TodoRepositoryProtocol
        
        var todoResponse: GetAllTodoResponse?
        var errorMessage: String?
        
        init(repository: TodoRepositoryProtocol) {
            self.repository = repository
        }
        
        func getAllTodo() async {
            do {
                let response = try await self.repository.getAllTodos()
                
                self.todoResponse = response
            } catch let error as NetworkError {
                self.errorMessage = error.localizedDescription
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
        
        func deleteTodo(id: Int) async {
            do {
                let response = try await self.repository.deleteTodo(id: id)
                let removedTodo = self.todoResponse?.todos?.filter { $0.id != response?.id }
                
                self.todoResponse?.todos = removedTodo
            } catch let error as NetworkError {
                self.errorMessage = error.localizedDescription
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
