//
//  ImageCacheManager.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 01/12/2025.
//

import Foundation
import UIKit

protocol ImageCacheProtocol: Sendable {
    static var shared: Self { get }
    
    func image(for url: URL) async throws -> UIImage
    func cache(image: UIImage, for url: URL) async
    func remove(for url: URL) async
    func removeAll() async
}

actor ImageCacheManager {
    
    // MARK: - SINGLETON -
    static let shared = ImageCacheManager()
    
    // MARK: - PROPERTIES -
    
    //Normal
    private let memoryCache = NSCache<NSURL, UIImage>()
    private let fileManager = FileManager.default
    //Lazy
    private lazy var diskDirectory: URL = {
        let url = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
            .appendingPathComponent("ImageCache", isDirectory: true)
        
        if !self.fileManager.fileExists(atPath: url.path) {
            try? self.fileManager.createDirectory(at: url, withIntermediateDirectories: true)
        }
        
        return url
    }()
    
    // MARK: - INITIALIZER -
    private init() { }
}

// MARK: - IMAGE CACHE PROTOCOL METHODS -
extension ImageCacheManager: ImageCacheProtocol {
    
    func image(for url: URL) async throws -> UIImage {
        let nsURL = url as NSURL
        
        // 1. Check memory cache
        if let cached = self.memoryCache.object(forKey: nsURL) {
            return cached
        }
        
        // 2. Check disk cache
        if let diskImage = self.loadFromDisk(url) {
            self.memoryCache.setObject(diskImage, forKey: nsURL)
            return diskImage
        }
        
        // 3. Download + decode on a background thread
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        // 4. Store in caches
        self.memoryCache.setObject(image, forKey: nsURL)
        self.saveToDisk(image: image, url: url)
        
        return image
    }
    
    func cache(image: UIImage, for url: URL) async {
        let nsURL = url as NSURL
        
        self.memoryCache.setObject(image, forKey: nsURL)
        self.saveToDisk(image: image, url: url)
    }
    
    func remove(for url: URL) async {
        self.memoryCache.removeObject(forKey: url as NSURL)
        self.removeFromDisk(url)
    }
    
    func removeAll() async {
        self.memoryCache.removeAllObjects()
        try? self.fileManager.removeItem(at: self.diskDirectory)
        try? self.fileManager.createDirectory(at: self.diskDirectory, withIntermediateDirectories: true)
    }
}

// MARK: - FUNCTIONS -
extension ImageCacheManager {
    
    /// In order to load the image from the disk cache
    /// - Parameter url: `URL` in order to get the disk path using url
    /// - Returns: `UIImage?` will return the image from the url path
    private func loadFromDisk(_ url: URL) -> UIImage? {
        let diskPath = self.diskDirectory.appendingPathComponent(self.cacheFileName(for: url))
        
        guard self.fileManager.fileExists(atPath: diskPath.path),
              let data = try? Data(contentsOf: diskPath),
              let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
    
    /// In order to save the image into the designated disk url
    /// - Parameters:
    ///   - image: `UIImage` image which needs to be saved in the disk url
    ///   - url: `URL` in order to make disk path in which image will be saved
    private func saveToDisk(image: UIImage, url: URL) {
        let diskPath = self.diskDirectory.appendingPathComponent(self.cacheFileName(for: url))
        
        guard let data = image.pngData() else { return }
        
        try? data.write(to: diskPath)
    }
    
    /// In order to remove the image from the disk
    /// - Parameter url: `URL` in order to navigate to the designation url
    private func removeFromDisk(_ url: URL) {
        let diskPath = self.diskDirectory.appendingPathComponent(self.cacheFileName(for: url))
        try? self.fileManager.removeItem(at: diskPath)
    }
    
    /// In order to make cache file name
    /// - Parameter url: `URL` in order to make cache file name using url
    /// - Returns: `String` will return the url path
    private func cacheFileName(for url: URL) -> String {
        url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
    }
}
