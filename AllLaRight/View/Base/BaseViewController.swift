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
        
        let vc = InfoPopupViewController()
        vc.modalPresentationStyle = .currentContext
        
        monitor.start(queue: .global())
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {

                return
                
            } else {
                DispatchQueue.main.async { [weak self] in
                    // TODO: 닫기버튼을 눌렀을 때 네트워크 재요청
                    vc.viewModel.errorMessage.accept("네트워크 연결이 일시적으로 원활하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요.")
                    self?.present(vc, animated: true)
                }
            }
        }
        
    }
}
