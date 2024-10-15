//
//  NetworkManager.swift
//  MatchMate
//
//  Created by Test on 15/10/24.
//

import Foundation
import Network

class NetworkConnectivity: ObservableObject {
    @Published var isConnected: Bool = false
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global(qos: .background)
    
    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
