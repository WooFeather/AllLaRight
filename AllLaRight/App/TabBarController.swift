//
//  TabBarController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
        setupTabBarAppearance()
        view.backgroundColor = .white
    }
    
    private func configureTabBarController() {
        tabBar.delegate = self
        
        let firstVC = MarketViewController()
        let secondVC = CoinInfoViewController()
        let thirdVC = PortfolioViewController()
        
        firstVC.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
        secondVC.tabBarItem.image = UIImage(systemName: "chart.bar.fill")
        thirdVC.tabBarItem.image = UIImage(systemName: "star")
        
        firstVC.tabBarItem.title = "거래소"
        secondVC.tabBarItem.title = "코인정보"
        thirdVC.tabBarItem.title = "포트폴리오"
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        setViewControllers([firstNav, secondNav, thirdNav], animated: true)
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .themePrimary
    }
}
