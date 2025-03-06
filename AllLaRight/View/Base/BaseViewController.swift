//
//  BaseViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureData()
        configureAction()
        bind()
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureData() { }
    
    func configureAction() { }
    
    func bind() { }
}
