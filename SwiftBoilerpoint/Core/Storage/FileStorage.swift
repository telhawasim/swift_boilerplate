//
//  FileStorage.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 01/12/2025.
//

import Foundation

private struct PrimitiveContainer<T: Codable & Sendable>: Codable, Sendable {
    let value: T
    
    private enum CodingKeys: String, CodingKey {
        case value
    }
    
    init(value: T) {
        self.value = value
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(T.self, forKey: .value)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
    }
}

// MARK: - FileStorage

public final class FileStorage: LocalAppStorage, @unchecked Sendable {
    
    // MARK: - SINGLETON -
    public static let shared = FileStorage()
    
    // MARK: - PROPERTIES -
    
    private let fileManager = FileManager.default
    private let folderName = "AppStorageFiles"
    
    private var folderURL: URL? {
        do {
            let documentsURL = try self.fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let folderURL = documentsURL.appendingPathComponent(self.folderName)
            
            if !self.fileManager.fileExists(atPath: folderURL.path) {
                try self.fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
            }
            return folderURL
        } catch {
            debugPrint("FileStorage folder error: \(error)")
            return nil
        }
    }
    
    // MARK: - INITIALIZER -
    private init() { }
        
    private func fileURL(forKey key: String) -> URL? {
        self.folderURL?.appendingPathComponent("\(key).json")
    }
    
    private func makeEncoder() -> JSONEncoder { JSONEncoder() }
    private func makeDecoder() -> JSONDecoder { JSONDecoder() }
        
    @discardableResult
    public func set<T: Codable & Sendable>(_ object: T?, forKey key: String) -> Bool {
        guard let fileURL = self.fileURL(forKey: key) else { return false }
        
        guard let object = object else {
            return self.remove(forKey: key)
        }
        
        do {
            let data = try self.makeEncoder().encode(object)
            try data.write(to: fileURL, options: .atomic)
            return true
        } catch {
            debugPrint("FileStorage write error: \(error)")
            return false
        }
    }
    
    public func object<T: Codable & Sendable>(forKey key: String, ofType type: T.Type) -> T? {
        guard let fileURL = self.fileURL(forKey: key),
              self.fileManager.fileExists(atPath: fileURL.path) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return try self.makeDecoder().decode(T.self, from: data)
        } catch {
            debugPrint("FileStorage read error: \(error)")
            return nil
        }
    }
    
    @discardableResult
    public func remove(forKey key: String) -> Bool {
        guard let fileURL = self.fileURL(forKey: key),
              self.fileManager.fileExists(atPath: fileURL.path) else { return true }
        
        do {
            try self.fileManager.removeItem(at: fileURL)
            return true
        } catch {
            debugPrint("FileStorage remove error: \(error)")
            return false
        }
    }
    
    @discardableResult
    public func removeAll() -> Bool {
        guard let folderURL = self.folderURL else { return false }
        
        do {
            try self.fileManager.removeItem(at: folderURL)
            return true
        } catch {
            debugPrint("FileStorage removeAll error: \(error)")
            return false
        }
    }
        
    @discardableResult
    public func set(_ value: Int?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        return self.setPrimitive(value, forKey: key)
    }
    
    @discardableResult
    public func set(_ value: Float?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        return self.setPrimitive(value, forKey: key)
    }
    
    @discardableResult
    public func set(_ value: Double?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        return self.setPrimitive(value, forKey: key)
    }
    
    @discardableResult
    public func set(_ value: Bool?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        return self.setPrimitive(value, forKey: key)
    }
    
    @discardableResult
    public func set(_ value: String?, forKey key: String) -> Bool {
        guard let value else { return self.remove(forKey: key) }
        return self.setPrimitive(value, forKey: key)
    }
        
    private func setPrimitive<T: Codable & Sendable>(_ value: T, forKey key: String) -> Bool {
        guard let fileURL = self.fileURL(forKey: key) else { return false }
        
        do {
            let container = PrimitiveContainer(value: value)
            let data = try self.makeEncoder().encode(container)
            try data.write(to: fileURL, options: .atomic)
            return true
        } catch {
            debugPrint("FileStorage write error: \(error)")
            return false
        }
    }
    
    private func getPrimitive<T: Codable & Sendable>(forKey key: String, type: T.Type) -> T? {
        guard let fileURL = self.fileURL(forKey: key),
              self.fileManager.fileExists(atPath: fileURL.path) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let container = try self.makeDecoder().decode(PrimitiveContainer<T>.self, from: data)
            return container.value
        } catch {
            debugPrint("FileStorage read error: \(error)")
            return nil
        }
    }
        
    public func integer(forKey key: String) -> Int? {
        self.getPrimitive(forKey: key, type: Int.self)
    }
    
    public func float(forKey key: String) -> Float? {
        self.getPrimitive(forKey: key, type: Float.self)
    }
    
    public func double(forKey key: String) -> Double? {
        self.getPrimitive(forKey: key, type: Double.self)
    }
    
    public func bool(forKey key: String) -> Bool? {
        self.getPrimitive(forKey: key, type: Bool.self)
    }
    
    public func string(forKey key: String) -> String? {
        self.getPrimitive(forKey: key, type: String.self)
    }
}
