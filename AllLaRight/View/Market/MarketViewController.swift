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
    private let viewModel = MarketViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    deinit {
        print("MarketViewController Deinit")
    }
    
    // MARK: - Functions
    override func bind() {
        let input = MarketViewModel.Input(
            currentPriceViewTapped: marketView.currentPriceView.rx.tapGesture(),
            compareToPreviousDayViewTapped: marketView.compareToPreviousDayView.rx.tapGesture(),
            tradePriceViewTapped: marketView.tradePriceView.rx.tapGesture()
        )
        let output = viewModel.transform(input: input)
        
        output.marketList
            .drive(marketView.marketTableView.rx.items(cellIdentifier: Identifier.MarketTableViewCell.rawValue, cellType: MarketTableViewCell.self)) { row, element, cell in
                cell.configureData(data: element)
            }
            .disposed(by: disposeBag)
        
        output.currentPriceViewState
            .drive(with: self) { owner, state in
                switch state {
                case .desc:
                    owner.marketView.currentPriceView.upperImageView.tintColor = .themeSecondary
                    owner.marketView.currentPriceView.lowerImageView.tintColor = .themePrimary
                case .asc:
                    owner.marketView.currentPriceView.upperImageView.tintColor = .themePrimary
                    owner.marketView.currentPriceView.lowerImageView.tintColor = .themeSecondary
                case .none:
                    owner.marketView.currentPriceView.upperImageView.tintColor = .themeSecondary
                    owner.marketView.currentPriceView.lowerImageView.tintColor = .themeSecondary
                }
            }
            .disposed(by: disposeBag)
        
        output.compareToPreviousDayViewState
            .drive(with: self) { owner, state in
                switch state {
                case .desc:
                    owner.marketView.compareToPreviousDayView.upperImageView.tintColor = .themeSecondary
                    owner.marketView.compareToPreviousDayView.lowerImageView.tintColor = .themePrimary
                case .asc:
                    owner.marketView.compareToPreviousDayView.upperImageView.tintColor = .themePrimary
                    owner.marketView.compareToPreviousDayView.lowerImageView.tintColor = .themeSecondary
                case .none:
                    owner.marketView.compareToPreviousDayView.upperImageView.tintColor = .themeSecondary
                    owner.marketView.compareToPreviousDayView.lowerImageView.tintColor = .themeSecondary
                }
            }
            .disposed(by: disposeBag)
        
        output.tradePriceViewState
            .drive(with: self) { owner, state in
                switch state {
                case .desc:
                    owner.marketView.tradePriceView.upperImageView.tintColor = .themeSecondary
                    owner.marketView.tradePriceView.lowerImageView.tintColor = .themePrimary
                case .asc:
                    owner.marketView.tradePriceView.upperImageView.tintColor = .themePrimary
                    owner.marketView.tradePriceView.lowerImageView.tintColor = .themeSecondary
                case .none:
                    owner.marketView.tradePriceView.upperImageView.tintColor = .themeSecondary
                    owner.marketView.tradePriceView.lowerImageView.tintColor = .themeSecondary
                }
            }
            .disposed(by: disposeBag)
        
        // TODO: 통신이 되기 전에는 인디케이터 표시
        
        // TODO: Error반환시 AlertView 띄우기
        // output.errorMessage
        
    }
    
    // MARK: - ConfigureView
    override func loadView() {
        view = marketView
    }
    
    override func configureData() {
        marketView.marketTableView.register(MarketTableViewCell.self, forCellReuseIdentifier: Identifier.MarketTableViewCell.rawValue)
    }
}
