//
//  CoinDetailViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import UIKit

final class CoinDetailViewController: BaseViewController {
    
    private let coinDetailView = CoinDetailView()
    // TODO: 별도의 navigationView 만들어서 CoinDetailView에서 적용
    private let navigationView = NavigationTitleView(title: "테스트")
    
    override func loadView() {
        view = coinDetailView
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func bookmarkButtonTapped() {
        print("bookmarkButtonTapped")
    }
    
    override func configureView() {
        super.configureView()
        
        let arrowImage = UIImage(systemName: "arrow.left")
        let backButton = UIBarButtonItem(image: arrowImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.setLeftBarButton(backButton, animated: true)
        
        let starImage = UIImage(systemName: "star")
        let bookmarkButton = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(bookmarkButtonTapped))
        navigationItem.setRightBarButton(bookmarkButton, animated: true)
    }
}
