//
//  String+Ext.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 02/12/2025.
//

import Foundation

extension String {
    var localized: String {
        LanguageManager.shared.localizedString(self)
    }
    
    func localized(arguments: CVarArg...) -> String {
        LanguageManager.shared.localizedString(self, arguments: arguments)
    }
}
