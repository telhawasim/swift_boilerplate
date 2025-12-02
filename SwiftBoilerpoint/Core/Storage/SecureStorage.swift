//
//  SecureStorage.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 01/12/2025.
//

import Foundation
import SecureDefaults

public final class SecureStorage: LocalAppStorage, @unchecked Sendable {
    
    // MARK: - SINGLETON -
    public static let shared = SecureStorage()
    
    // MARK: - PROPERTIES -
    private let secureDefaults: SecureDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - INITIALIZER -
    private init() {
        self.secureDefaults = SecureDefaults.shared
        if !self.secureDefaults.isKeyCreated {
            self.secureDefaults.password = UUID().uuidString
        }
    }
    
    @discardableResult
    public func set<T: Codable & Sendable>(_ object: T?, forKey key: String) -> Bool {
        guard let object = object else {
            self.secureDefaults.removeObject(forKey: key)
            return true
        }
        do {
            let data = try encoder.encode(object)
            self.secureDefaults.set(data, forKey: key)
            return true
        } catch {
            debugPrint("SecureStorage encoding error: \(error)")
            return false
        }
    }
    
    public func object<T: Codable & Sendable>(forKey key: String, ofType type: T.Type) -> T? {
        guard let data = self.secureDefaults.object(forKey: key) as? Data else { return nil }
        do {
            return try self.decoder.decode(T.self, from: data)
        } catch {
            debugPrint("SecureStorage decoding error: \(error)")
            return nil
        }
    }
    
    @discardableResult
    public func remove(forKey key: String) -> Bool {
        self.secureDefaults.removeObject(forKey: key)
        return true
    }
    
    @discardableResult
    public func removeAll() -> Bool {
        self.secureDefaults.dictionaryRepresentation().keys.forEach { key in
            self.secureDefaults.removeObject(forKey: key)
        }
        self.secureDefaults.synchronize()
        return true
    }
    
    // MARK: - Primitives
    
    @discardableResult
    public func set(_ value: Int?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        self.secureDefaults.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    public func set(_ value: Float?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        self.secureDefaults.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    public func set(_ value: Double?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        self.secureDefaults.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    public func set(_ value: Bool?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        self.secureDefaults.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    public func set(_ value: String?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        self.secureDefaults.set(value, forKey: key)
        return true
    }
    
    public func integer(forKey key: String) -> Int? {
        self.secureDefaults.object(forKey: key) as? Int
    }
    
    public func float(forKey key: String) -> Float? {
        self.secureDefaults.object(forKey: key) as? Float
    }
    
    public func double(forKey key: String) -> Double? {
        self.secureDefaults.object(forKey: key) as? Double
    }
    
    public func bool(forKey key: String) -> Bool? {
        self.secureDefaults.object(forKey: key) as? Bool
    }
    
    public func string(forKey key: String) -> String? {
        self.secureDefaults.string(forKey: key)
    }
}
