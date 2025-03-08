//
//  CoinInfoViewController.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class CoinInfoViewController: BaseViewController {
    private let coinInfoView = CoinInfoView()
    private let navigationView = NavigationTitleView(title: "가상자산 / 심볼 검색")
    private let viewModel = CoinInfoViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    deinit {
        print("CoinInfoViewController Deinit")
    }

    // MARK: - Functions
    override func bind() {
        let input = CoinInfoViewModel.Input()
        let output = viewModel.transform(input: input)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<MultipleSectionModel> { dataSource, collectionView, indexPath, item in
            switch item {
            case .trendingCoin(trendingCoin: _):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCoinCollectionViewCell.id, for: indexPath) as? TrendingCoinCollectionViewCell else { return UICollectionViewCell() }
                
                
                return cell
            case .trendingNFT(trendingNFT: _):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingNFTCollectionViewCell.id, for: indexPath) as? TrendingNFTCollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
        }
        
        output.layout
            .drive(coinInfoView.infoCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    // MARK: - ConfigureView
    override func loadView() {
        view = coinInfoView
    }
    
    override func configureView() {
        navigationItem.titleView = navigationView
    }
    
    override func configureData() {
        // TODO: headerView 등록
        coinInfoView.infoCollectionView.register(TrendingCoinCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCoinCollectionViewCell.id)
        
        coinInfoView.infoCollectionView.register(TrendingNFTCollectionViewCell.self, forCellWithReuseIdentifier: TrendingNFTCollectionViewCell.id)
    }
}
