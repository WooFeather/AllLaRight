//
//  MarketViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit

final class MarketViewController: BaseViewController {

    private let marketView = MarketView()
    private let navigationView = NavigationTitleView(title: "거래소")
    
    override func loadView() {
        view = marketView
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.titleView = navigationView
    }
}
