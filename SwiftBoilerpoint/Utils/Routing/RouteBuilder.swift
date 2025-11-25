//
//  RouteBuilder.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import SwiftUI

struct RouteBuilder {
    
    @ViewBuilder
    static func build(for route: Route) -> some View {
        switch route {
        case .todoDetail:
            TodoDetailView()
        }
    }
}
