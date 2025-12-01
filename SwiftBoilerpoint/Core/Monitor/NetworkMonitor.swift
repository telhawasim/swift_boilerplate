//
//  NetworkMonitor.swift
//  SwiftBoilerpoint
//
//  Created by Telha Wasim on 01/12/2025.
//

import Foundation
import Network
import SwiftUI
import Combine

final class NetworkMonitor: ObservableObject {
    
    enum ConnectionType {
        case wifi
        case ceullular
        case ethernet
        case unknown
    }
    
    // MARK: - SINGLETON -
    static let shared = NetworkMonitor()
    
    // MARK: - PROPERTIES -
    
    //Normal
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    //Published
    @Published var isConnected: Bool = true
    @Published var connectedType: ConnectionType = .unknown
    
    // MARK: - INITIALIZER -
    private init() {
        self.startMonitoring()
    }
}

// MARK: - FUNCTIONS -
extension NetworkMonitor {
    
    /// In order to start the monitoring in order to determine the connection status
    func startMonitoring() {
        self.monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isConnected = path.status == .satisfied
                self.connectedType = self.getConnectionType(path)
            }
        }
        self.monitor.start(queue: self.queue)
    }
    
    /// In order to stop the monitoring
    func stopMonitoring() {
        self.monitor.cancel()
    }
    
    /// In order to detemine the medium of connection from the internet
    /// - Parameter path: `NWPath` will be ret
    /// - Returns: `ConnectionType` will return the medium for connection
    private func getConnectionType(_ path: NWPath) -> ConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.cellular) {
            return .ceullular
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else {
            return .unknown
        }
    }
}
