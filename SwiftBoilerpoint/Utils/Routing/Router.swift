//
//  Router.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import SwiftUI
import Combine

enum AppState {
    case splash
    case auth
    case main
}

final class Router: ObservableObject {
    
    // MARK: - PROPERTIES -
    
    //Published
    @Published var appState: AppState = .splash
    @Published var selectedTab: TabbarType = .todos
    @Published var todoPath = NavigationPath()
    @Published var settingsPath = NavigationPath()
    
    /// In order to navigate the user to new screen
    /// - Parameter route: `Route` will be needed in order to navigate to new screen
    func push(to route: Route) {
        switch self.selectedTab {
        case .todos:
            self.todoPath.append(route)
        case .settings:
            self.settingsPath.append(route)
        }
    }
    
    /// In order to navigate the user backwards
    func pop() {
        switch self.selectedTab {
        case .todos:
            self.todoPath.removeLast()
        case .settings:
            self.settingsPath.removeLast()
        }
    }
}
