//
//  SwiftBoilerpointApp.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import SwiftUI

@main
struct SwiftBoilerpointApp: App {
    
    // MARK: - PROPERTIES -
    
    //StateObject
    @StateObject private var router = Router()
    @StateObject private var languageManager = LanguageManager.shared
    //State
    
    // MARK: - LIFECYCLE -
    var body: some Scene {
        WindowGroup {
            TabbarView()
                .customNetworkAlert()
                .environmentObject(self.router)
                .environmentObject(self.languageManager)
                .preferredColorScheme(
                    AppData.isDarkMode == true ? .dark : .light
                )
        }
    }
}
