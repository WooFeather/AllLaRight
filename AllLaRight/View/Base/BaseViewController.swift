//
//  BaseViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import Network

class BaseViewController: UIViewController {
    
    let monitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startMonitoring()
        
        configureView()
        configureData()
        configureAction()
        bind()
    }
    
    func configureView() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureData() { }
    
    func configureAction() { }
    
    func bind() { }
    
    func startMonitoring() {
        
        // alert이 아니라 vc를 띄우면 무한으로 올라오는 문제 발생
//        let vc = InfoPopupViewController()
//        vc.modalPresentationStyle = .currentContext
        
        monitor.start(queue: .global())
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {

                return
                
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "네트워크 오류", message: "네트워크 연결이 일시적으로 원활하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요.", button: "닫기", isCancelButton: false) {
                        self.dismiss(animated: true)
                    }
                }
            }
            
        }
        
    }
}
