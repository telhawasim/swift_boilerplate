//
//  TodoItemView.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import SwiftUI

struct TodoItemView: View {
    
    // MARK: - PROPERTIES -
    
    var todo: Todos?
    
    // MARK: - VIEWS -
    var body: some View {
        HStack(spacing: 16) {
            Text("\(self.todo?.id ?? 0)")
                .font(.headline)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                )
            
            VStack(alignment: .leading) {
                Text(self.todo?.todo ?? "")
                    .font(.callout.bold())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.primary)
        )
        .contentShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    TodoItemView()
}
