//
//  AppData.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 02/12/2025.
//

import SwiftUI
import Observation

@Observable
@MainActor
public final class AppData {
    
    // MARK: - SINGLETON -
    public static let shared = AppData()
    
    // MARK: - STORED KEYS -
    private enum Keys {
        static let isDarkMode = "isDarkMode"
        static let appLanguage = "appLanguage"
    }
    
    // MARK: - STORAGE REFERENCES
    private let defaults = DefaultsStorage.shared
    private let secure = SecureStorage.shared
    private let file = FileStorage.shared
    
    // MARK: - STORED PROPERTIES -
    private var _isDarkMode: Bool = false
    private var _appLanguage: String = "system"
    
    // MARK: - INITIALIZER -
    private init() {
        self._isDarkMode = self.defaults.bool(forKey: Keys.isDarkMode) ?? false
        self._appLanguage = self.defaults.string(forKey: Keys.appLanguage) ?? "system"
    }
    
    // MARK: - PUBLIC PROPERTIES -
    public var isDarkMode: Bool {
        get { self._isDarkMode }
        set {
            self._isDarkMode = newValue
            self.defaults.set(newValue, forKey: Keys.isDarkMode)
        }
    }
    
    public var appLanguage: String {
        get { self._appLanguage }
        set {
            self._appLanguage = newValue
            self.defaults.set(newValue, forKey: Keys.appLanguage)
        }
    }
    
    // MARK: - STATIC ACCESSORS -
    public static var isDarkMode: Bool {
        get { self.shared.isDarkMode }
        set { self.shared.isDarkMode = newValue }
    }
    
    public static var appLanguage: String {
        get { self.shared.appLanguage }
        set { self.shared.appLanguage = newValue }
    }
    
    // MARK: - RESET -
    public func reset() {
        self.isDarkMode = false
    }
    
    public static func reset() {
        self.shared.reset()
    }
}
