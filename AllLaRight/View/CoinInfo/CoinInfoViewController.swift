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
        
        // TODO: 2개의 cell과 2개의 section으로 구성된 rxDataSource 구성하기
//        let dataSource = RxCollectionViewSectionedReloadDataSource<> { <#UICollectionView#>, <#IndexPath#>, <#SectionModelType.Item#> in
//            <#code#>
//        }
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
        coinInfoView.infoCollectionView.register(TrendingKeywordCollectionViewCell.self, forCellWithReuseIdentifier: TrendingKeywordCollectionViewCell.id)
        
        coinInfoView.infoCollectionView.register(TrendingNFTCollectionViewCell.self, forCellWithReuseIdentifier: TrendingNFTCollectionViewCell.id)
    }
}
