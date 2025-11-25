//
//  AppearanceManager.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import Foundation
import Combine
import SwiftUI

final class AppearanceManager: ObservableObject {
    
    enum Appearance: String {
        case system
        case light
        case dark
    }
    
    @AppStorage("app_appearance") var storedAppearance: String = Appearance.system.rawValue {
        didSet { objectWillChange.send() }
    }
    
    var currentAppearance: Appearance {
        Appearance(rawValue: storedAppearance) ?? .system
    }
    
    func toogleDarkMode(_ isOn: Bool) {
        self.storedAppearance = isOn ? Appearance.dark.rawValue : Appearance.light.rawValue
    }
}
