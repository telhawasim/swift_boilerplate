//
//  StorageProtocols.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 01/12/2025.
//

import SwiftUI
import Observation
import Combine

public protocol AnyOptional: Sendable {
    var isNil: Bool { get }
}

public protocol LocalAppStorage: Sendable {
    func set<T: Codable & Sendable>(_ object: T?, forKey key: String) -> Bool
    func object<T: Codable & Sendable>(forKey key: String, ofType type: T.Type) -> T?
    func remove(forKey key: String) -> Bool
    func removeAll() -> Bool
    
    // Primitives
    func set(_ value: Int?, forKey key: String) -> Bool
    func set(_ value: Float?, forKey key: String) -> Bool
    func set(_ value: Double?, forKey key: String) -> Bool
    func set(_ value: Bool?, forKey key: String) -> Bool
    func set(_ value: String?, forKey key: String) -> Bool
    
    func integer(forKey key: String) -> Int?
    func float(forKey key: String) -> Float?
    func double(forKey key: String) -> Double?
    func bool(forKey key: String) -> Bool?
    func string(forKey key: String) -> String?
}

public enum StoreType: String, CaseIterable, Sendable {
    case defaults
    case secure
    case file
    
    @MainActor
    func storage() -> LocalAppStorage {
        switch self {
        case .defaults: return DefaultsStorage.shared
        case .secure: return SecureStorage.shared
        case .file: return FileStorage.shared
        }
    }
}
