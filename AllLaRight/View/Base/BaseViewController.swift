//
//  BaseViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import Network

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NetworkMonitor.shared.startMonitoring(self)
        configureView()
        configureData()
        configureAction()
        bind()
    }
    
    func configureView() {
        view.backgroundColor = .themeBackground
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureData() { }
    
    func configureAction() { }
    
    func bind() { }
}
