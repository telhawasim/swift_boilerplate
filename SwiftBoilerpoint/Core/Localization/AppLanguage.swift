//
//  AppLanguage.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 02/12/2025.
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case system = "system"
    case english = "en"
    case spanish = "es"
    
    var id: String { rawValue }
    
    var code: String {
        switch self {
        case .system: return Locale.preferredLanguages.first?.prefix(2).lowercased() ?? "en"
        case .english: return "en"
        case .spanish: return "es"
        }
    }
    
    var displayName: String {
        switch self {
        case .system: return "System"
        case .english: return "English"
        case .spanish: return "Español"
        }
    }
    
    var flag: String {
        switch self {
        case .system: return "🌐"
        case .english: return "🇺🇸"
        case .spanish: return "🇪🇸"
        }
    }
}
