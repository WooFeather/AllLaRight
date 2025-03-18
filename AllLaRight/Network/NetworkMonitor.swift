//
//  NetworkConnectionChecker.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import UIKit
import Network

final class NetworkMonitor{
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    private(set) var isConnected: Bool = false
    private(set) var connectionType: ConnectionType = .unknown
    
    // 연결타입
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init(){
        print("init 호출")
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(_ viewController: UIViewController) {
        let vc = InfoPopupViewController()
        vc.modalPresentationStyle = .overCurrentContext
        
        monitor.start(queue: .global())
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self?.isConnected = true
                } else {
                    self?.isConnected = false
                    viewController.present(vc, animated: true)
                }
            }
        }
    }
    
    public func stopMonitoring(){
        print("stopMonitoring 호출")
        monitor.cancel()
    }
    
    
    private func getConnectionType(_ path:NWPath) {
        print("getConnectionType 호출")
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
            print("wifi에 연결")
            
        }else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
            print("cellular에 연결")
            
        }else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
            print("wiredEthernet에 연결")
            
        }else {
            connectionType = .unknown
            print("unknown ..")
        }
    }
}
