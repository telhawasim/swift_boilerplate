//
//  Enums.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

enum TabbarType: String, CaseIterable {
    case todos
    case settings
    
    var getIcon: String {
        switch self {
        case .todos:
            return "house"
        case .settings:
            return "gear"
        }
    }
}
