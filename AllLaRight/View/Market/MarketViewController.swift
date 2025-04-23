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
        
        LoadingIndicator.showLoading()
        
        output.marketList
            .drive(marketView.marketTableView.rx.items(cellIdentifier: Identifier.MarketTableViewCell.rawValue, cellType: MarketTableViewCell.self)) { row, element, cell in
                LoadingIndicator.hideLoading()
                cell.configureData(data: element)
            }
            .disposed(by: disposeBag)
        
        output.currentPriceViewState
            .drive(with: self) { owner, state in
                switch state {
                case .desc:
                    owner.marketView.currentPriceView.upperImageView.tintColor = .themeSecondary
                    owner.marketView.currentPriceView.lowerImageView.tintColor = .textPrimary
                case .asc:
                    owner.marketView.currentPriceView.upperImageView.tintColor = .textPrimary
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
                    owner.marketView.compareToPreviousDayView.lowerImageView.tintColor = .textPrimary
                case .asc:
                    owner.marketView.compareToPreviousDayView.upperImageView.tintColor = .textPrimary
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
                    owner.marketView.tradePriceView.lowerImageView.tintColor = .textPrimary
                case .asc:
                    owner.marketView.tradePriceView.upperImageView.tintColor = .textPrimary
                    owner.marketView.tradePriceView.lowerImageView.tintColor = .themeSecondary
                case .none:
                    owner.marketView.tradePriceView.upperImageView.tintColor = .themeSecondary
                    owner.marketView.tradePriceView.lowerImageView.tintColor = .themeSecondary
                }
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
           .drive(with: self) { owner, value in
               LoadingIndicator.hideLoading()
               
               let vc = InfoPopupViewController()
               vc.viewModel.errorMessage.accept(value)
               vc.modalPresentationStyle = .currentContext
               owner.present(vc, animated: true)
           }
           .disposed(by: disposeBag)
    }
    
    // MARK: - ConfigureView
    override func loadView() {
        view = marketView
    }
    
    override func configureData() {
        marketView.marketTableView.register(MarketTableViewCell.self, forCellReuseIdentifier: Identifier.MarketTableViewCell.rawValue)
    }
}
