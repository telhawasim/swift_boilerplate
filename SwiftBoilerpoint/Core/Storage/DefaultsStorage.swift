//
//  DefaultsStorage.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 01/12/2025.
//

import Foundation

public final class DefaultsStorage: LocalAppStorage, @unchecked Sendable {
    
    // MARK: - SINGLETON -
    public static let shared = DefaultsStorage()
    
    // MARK: - PROPERTIES -
    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - INITIALIZER -
    private init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    @discardableResult
    public func set<T: Codable & Sendable>(_ object: T?, forKey key: String) -> Bool {
        guard let object = object else {
            self.defaults.removeObject(forKey: key)
            return true
        }
        do {
            let data = try self.encoder.encode(object)
            self.defaults.set(data, forKey: key)
            return true
        } catch {
            debugPrint("DefaultsStorage encoding error: \(error)")
            return false
        }
    }
    
    public func object<T: Codable & Sendable>(forKey key: String, ofType type: T.Type) -> T? {
        guard let data = self.defaults.data(forKey: key) else { return nil }
        do {
            return try self.decoder.decode(T.self, from: data)
        } catch {
            debugPrint("DefaultsStorage decoding error: \(error)")
            return nil
        }
    }
    
    @discardableResult
    public func remove(forKey key: String) -> Bool {
        self.defaults.removeObject(forKey: key)
        return true
    }
    
    @discardableResult
    public func removeAll() -> Bool {
        guard let bundleID = Bundle.main.bundleIdentifier else { return false }
        
        self.defaults.removePersistentDomain(forName: bundleID)
        self.defaults.synchronize()
        
        return true
    }
    
    @discardableResult
    public func set(_ value: Int?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        
        self.defaults.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    public func set(_ value: Float?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        
        self.defaults.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    public func set(_ value: Double?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        
        self.defaults.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    public func set(_ value: Bool?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        
        self.defaults.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    public func set(_ value: String?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        
        self.defaults.set(value, forKey: key)
        return true
    }
    
    public func integer(forKey key: String) -> Int? {
        self.defaults.object(forKey: key) as? Int
    }
    
    public func float(forKey key: String) -> Float? {
        self.defaults.object(forKey: key) as? Float
    }
    
    public func double(forKey key: String) -> Double? {
        self.defaults.object(forKey: key) as? Double
    }
    
    public func bool(forKey key: String) -> Bool? {
        self.defaults.object(forKey: key) as? Bool
    }
    
    public func string(forKey key: String) -> String? {
        self.defaults.object(forKey: key) as? String
    }
}
