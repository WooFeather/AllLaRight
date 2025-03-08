//
//  PortfolioViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit

final class PortfolioViewController: BaseViewController {
    private let navigationView = NavigationTitleView(title: "포트폴리오")
    
    override func configureView() {
        navigationItem.titleView = navigationView
    }
}
