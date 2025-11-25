//
//  Config.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 25/11/2025.
//

import Foundation

public final class EnvironmentManager {
    
    public enum Environment {
        case staging, production
    }
    public enum EnvironmentVariable: String {
        case debugStaging = "Debug-Staging"
        case debugProd = "Debug-Production"
        case releaseStaging = "Release-Staging"
        case releaseProd = "Release-Production"
    }
        
    private static let infoDictionary: [String: Any] = {
        Bundle.main.infoDictionary ?? [:]
    }()
    
    static let environment: String = {
        guard let key = infoDictionary["ENVIRONMENT"] as? String else {
            fatalError("ENVIRONMENT not found in info.plist")
        }
        
        return key
    }()
    
    static let configuration: String = {
        guard let key = infoDictionary["Configuration"] as? String else {
            fatalError("Configuration not found in info.plist")
        }
        
        return key
    }()
    
    static let baseURL: String = {
        guard let key = infoDictionary["BASE_URL"] as? String else {
            fatalError("BASE_URL not found in info.plist")
        }
        
        return key
    }()
    
    static func getCurrentEnvironment() -> Environment {
        guard let environment = EnvironmentVariable(rawValue: EnvironmentManager.configuration) else {
            fatalError("Invalid configuration")
        }
        
        switch environment {
        case .debugStaging, .releaseStaging:
            return .staging
        case .debugProd, .releaseProd:
            return .production
        }
    }
}
