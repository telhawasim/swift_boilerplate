//
//  TabbarView.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import SwiftUI

struct TabbarView: View {
    
    // MARK: - PROPERTIES -
    
    //EnvironmentObject
    @EnvironmentObject private var router: Router
    
    // MARK: - VIEWS -
    var body: some View {
        TabView(selection: self.$router.selectedTab) {
            ForEach(TabbarType.allCases, id: \.rawValue) { tab in
                Tab(tab.rawValue, systemImage: tab.getIcon, value: tab) {
                    NavigationStack(path: self.handleNavigationPath(tab)) {
                        self.tabContent(for: tab)
                            .navigationDestination(for: Route.self) { route in
                                RouteBuilder.build(for: route)
                            }
                    }
                }
            }
        }
    }
}

// MARK: - FUNCTIONS -
extension TabbarView {
    
    /// In order to handle the multiple navigation path for navigation
    /// - Parameter tab: `TabbarType` will be needing in order to determine which navigation path to handle
    /// - Returns: `Binding<NavigationPath>` will return the path
    private func handleNavigationPath(_ tab: TabbarType) -> Binding<NavigationPath> {
        switch tab {
        case .todos:
            return self.$router.todoPath
        case .settings:
            return self.$router.settingsPath
        }
    }
    
    /// In order to determine the view according to the selected tab
    /// - Parameter tab: `TabbarType` will be needing in order to determine which view to show
    /// - Returns: `some View` will return the screen
    @ViewBuilder
    private func tabContent(for tab: TabbarType) -> some View {
        switch tab {
        case .todos:
            TodoView(viewModel: DIContainer.shared.makeTodoViewModel())
        case .settings:
            SettingView()
        }
    }
}

#Preview {
    TabbarView()
        .environmentObject(Router())
}
