//
//  MarketViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa

final class MarketViewController: BaseViewController {

    private let marketView = MarketView()
    private let navigationView = NavigationTitleView(title: "거래소")
    private let viewModel = MarketViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    deinit {
        print("MarketViewController Deinit")
    }
    
    // MARK: - Functions
    override func bind() {
        let input = MarketViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.marketList
            .drive(marketView.marketTableView.rx.items(cellIdentifier: MarketTableViewCell.id, cellType: MarketTableViewCell.self)) { row, element, cell in
                cell.configureData(data: element)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    
    // TODO: 각 버튼을 탭했을 때 이미지의 색상 변경 및 정렬
    @objc
    private func currentPriceViewTapped() {
        print("현재가")
    }
    
    @objc
    private func compareToPreviousDayViewTapped() {
        print("전일대비")
    }
    
    @objc
    private func tradePriceViewTapped() {
        print("거래대금")
    }
    
    // MARK: - ConfigureView
    override func loadView() {
        view = marketView
    }
    
    override func configureView() {
        navigationItem.titleView = navigationView
    }
    
    override func configureData() {
        marketView.marketTableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.id)
    }
    
    override func configureAction() {
        // TODO: RxGesture 알아보기
        let currentPriceViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(currentPriceViewTapped))
        marketView.currentPriceView.addGestureRecognizer(currentPriceViewTapGesture)
        
        let compareToPreviousDayViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(compareToPreviousDayViewTapped))
        marketView.compareToPreviousDayView.addGestureRecognizer(compareToPreviousDayViewTapGesture)
        
        let tradePriceViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(tradePriceViewTapped))
        marketView.tradePriceView.addGestureRecognizer(tradePriceViewTapGesture)
    }
}
