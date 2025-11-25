//
//  TodoView.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import SwiftUI

struct TodoView: View {
    
    // MARK: - PROPERTIES -
    
    //EnvironmentObject
    @EnvironmentObject private var router: Router
    //State
    @State var viewModel: TodoView.ViewModel
    
    // MARK: - VIEWS -
    var body: some View {
        VStack(spacing: 0) {
            if let todods = self.viewModel.todoResponse?.todos {
                if todods.isEmpty {
                    Text("No Data")
                } else {
                    List {
                        ForEach(todods, id: \.id) { todo in
                            TodoItemView(todo: todo)
                                .onTapGesture {
                                    self.router.push(to: .todoDetail)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        Task {
                                            await self.viewModel.deleteTodo(id: todo.id ?? 0)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    .tint(.blue)
                                }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                }
            } else {
                
            }
        }
        .task {
            await self.viewModel.getAllTodo()
        }
        .navigationTitle("Todo")
    }
}

#Preview {
    TodoView(
        viewModel: DIContainer.shared.makeTodoViewModel()
    )
    .environmentObject(Router())
}
