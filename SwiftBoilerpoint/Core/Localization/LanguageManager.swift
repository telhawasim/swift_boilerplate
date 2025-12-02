//
//  LanguageManager.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 02/12/2025.
//

import SwiftUI
import Foundation
import Combine

final class LanguageManager: ObservableObject {
    
    // MARK: - SINGLETON -
    static let shared = LanguageManager()
    
    // MARK: - PROPERTIES -
    
    //Computed
    @Published var currentLanguage: AppLanguage = .system {
        didSet {
            self.saveLanguage()
        }
    }
    
    // MARK: - INITIALZIER -
    private init() {
        let savedLanguage = AppData.appLanguage
        self.currentLanguage = AppLanguage(rawValue: savedLanguage) ?? .system
    }
}

// MARK: - FUNCTIONS -
extension LanguageManager {
    
    // MARK: - SAVE LANGUAGE -
    private func saveLanguage() {
        AppData.appLanguage = self.currentLanguage.rawValue
    }
    
    // MARK: - LOCALIZED STRING -
    func localizedString(_ key: String, arguments: CVarArg...) -> String {
        let bundle: Bundle
        
        switch self.currentLanguage {
        case .system:
            bundle = .main
        case .english, .spanish:
            if let path = Bundle.main.path(forResource: self.currentLanguage.code, ofType: "lproj"),
               let langBundle = Bundle(path: path) {
                bundle = langBundle
            } else {
                bundle = .main
            }
        }
        
        let format = NSLocalizedString(key, bundle: bundle, comment: "")
        return String(format: format, arguments)
    }
}
