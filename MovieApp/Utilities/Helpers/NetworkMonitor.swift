//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 17.10.2022.
//

import Foundation
import Network
final class NetworkMonitor {
    
    static let shared = NetworkMonitor()

    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    public private(set) var isConnected: Bool = false
    
    public private(set) var connectionType: ConnectionType = .unknown

    private init() {
        self.monitor = NWPathMonitor()
    }

    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in

            self?.isConnected = path.status == .satisfied ? true : false
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            self.connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            self.connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            self.connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
}

enum ConnectionType {
    case wifi
    case cellular
    case ethernet
    case unknown
}
