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
    
    // MARK: - Initializer
    deinit {
        print("MarketViewController Deinit")
    }
    
    // MARK: - Functions
    override func bind() {
        
    }
    
    // MARK: - Actions
    
    // TODO: 각 버튼을 탭했을 때 이미지의 색상 변경 및 정렬
    @objc
    private func currentPriceButtonTapped() {
        print("현재가")
    }
    
    @objc
    private func compareToPreviousDayButtonTapped() {
        print("전일대비")
    }
    
    @objc
    private func transactionPriceButtonTapped() {
        print("거래대금")
    }
    
    // MARK: - ConfigureView
    override func loadView() {
        view = marketView
    }
    
    override func configureView() {
        navigationItem.titleView = navigationView
    }
    
    override func configureAction() {
        // TODO: RxGesture 알아보기
        let currentPriceButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(currentPriceButtonTapped))
        marketView.currentPriceButton.addGestureRecognizer(currentPriceButtonTapGesture)
        
        let compareToPreviousDayButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(compareToPreviousDayButtonTapped))
        marketView.compareToPreviousDayButton.addGestureRecognizer(compareToPreviousDayButtonTapGesture)
        
        let transactionPriceButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(transactionPriceButtonTapped))
        marketView.transactionPriceButton.addGestureRecognizer(transactionPriceButtonTapGesture)
    }
}
