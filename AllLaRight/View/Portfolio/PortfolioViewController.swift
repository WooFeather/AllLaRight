//
//  PortfolioViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit

final class PortfolioViewController: BaseViewController {
    private let portfolioView = PortfolioView()
    
    override func loadView() {
        view = portfolioView
    }
}
