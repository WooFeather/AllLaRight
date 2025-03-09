//
//  MarketViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

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
        let input = MarketViewModel.Input(
            viewWillAppear: rx.viewWillAppear,
            viewWillDisappear: rx.viewWillDisappear,
            currentPriceViewTapped: marketView.currentPriceView.rx.tapGesture(),
            compareToPreviousDayViewTapped: marketView.compareToPreviousDayView.rx.tapGesture(),
            tradePriceViewTapped: marketView.tradePriceView.rx.tapGesture()
        )
        let output = viewModel.transform(input: input)
        
        output.marketList
            .drive(marketView.marketTableView.rx.items(cellIdentifier: MarketTableViewCell.id, cellType: MarketTableViewCell.self)) { row, element, cell in
                cell.configureData(data: element)
            }
            .disposed(by: disposeBag)
        
        // TODO: 각 버튼을 탭했을 때 이미지의 색상 변경 및 정렬(인아웃으로)
//        marketView.currentPriceView.rx.tapGesture()
//            .when(.recognized)
//            .bind { _ in
//                print("현재가")
//            }
//            .disposed(by: disposeBag)
//        
//        marketView.compareToPreviousDayView.rx.tapGesture()
//            .when(.recognized)
//            .bind { _ in
//                print("전일대비")
//            }
//            .disposed(by: disposeBag)
//        
//        marketView.tradePriceView.rx.tapGesture()
//            .when(.recognized)
//            .bind { _ in
//                print("거래대금")
//            }
//            .disposed(by: disposeBag)
        
        // TODO: 통신이 되기 전에는 인디케이터 표시
        
        // TODO: Error반환시 AlertView 띄우기
        // output.errorMessage
        
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
}
