//
//  NetworkMonitor.swift
//  FireBaseEx
//
//  Created by HAHA on 25/8/2021.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject{
    static let instance = NetworkMonitor()
    
    let queue = DispatchQueue.global(qos: .background)
    let monitor = NWPathMonitor()

    @Published var isConnected: Bool = true
    @Published var networkAlert: Bool = false
    
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType{
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    init(){
        startMonitoring()
    }
    
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
            self?.getConnectionType(path: path)
        }
    }
    
    public func stopMonitoring(){
        monitor.cancel()
    }
    
    public func getConnectionType(path: NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }
        else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }
        else{
            connectionType = .unknown
        }
    }
}
