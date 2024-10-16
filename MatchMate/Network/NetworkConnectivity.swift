//
//  NetworkManager.swift
//  MatchMate
//
//  Created by Test on 15/10/24.
//

import Foundation
import Network

class NetworkConnectivity: ObservableObject {
 
    @Published var isConnected: Bool = true
    private var monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    private func startMonitoring() {
          monitor.pathUpdateHandler = { [weak self] path in
              guard let weakSelf = self else {return}
              DispatchQueue.main.async {
                  if path.status == .satisfied {
                      weakSelf.isConnected = true
                      print("Connected to the internet")
                  } else {
                      weakSelf.isConnected = false
                      print("No internet connection")
                  }
              }
          }
          
          monitor.start(queue: queue)
      }

    deinit {
        monitor.cancel()
    }
}
