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
        
        enableSwipeBackGesture()
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

// 뒤로가기 제스처
extension BaseViewController: UIGestureRecognizerDelegate {
    private func enableSwipeBackGesture() {
        if let navigationController = navigationController,
           navigationController.viewControllers.count > 1 {
            navigationController.interactivePopGestureRecognizer?.delegate = self
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}
