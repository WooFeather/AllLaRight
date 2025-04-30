//
//  PortfolioViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class PortfolioViewController: BaseViewController {
    private let portfolioView = PortfolioView()
    private let disposeBag = DisposeBag()
    let viewModel = PortfolioViewModel()
    
    override func bind() {
        let input = PortfolioViewModel.Input(
            viewWillAppear: rx.viewWillAppear
        )
        let output = viewModel.transform(input: input)
        
        output.portfolioData
            .drive(portfolioView.favoriteCollectionView.rx.items(cellIdentifier: Identifier.FavoriteCollectionViewCell.rawValue, cellType: FavoriteCollectionViewCell.self)) { item, element, cell in
                
                cell.configureData(data: element)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - ConfigureView
    override func loadView() {
        view = portfolioView
    }
    
    override func configureData() {
        portfolioView.favoriteCollectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.FavoriteCollectionViewCell.rawValue)
    }
}
