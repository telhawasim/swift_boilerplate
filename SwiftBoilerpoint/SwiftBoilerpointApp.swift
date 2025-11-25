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
    @StateObject private var appearance = AppearanceManager()
    @StateObject private var router = Router()
    
    // MARK: - LIFECYCLE -
    var body: some Scene {
        WindowGroup {
            TabbarView()
                .environmentObject(self.router)
                .environmentObject(self.appearance)
                .preferredColorScheme(
                    self.appearance.currentAppearance == .system ? nil : (self.appearance.currentAppearance == .dark ? .dark : .light)
                )
        }
    }
}
