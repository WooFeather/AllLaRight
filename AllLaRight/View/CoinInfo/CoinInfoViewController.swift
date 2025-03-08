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
        
//        let dataSource = RxCollectionViewSectionedReloadDataSource<MultipleSectionModel> { dataSource, collectionView, indexPath, item in
//            switch item {
//            case let .trendingCoin(trendingCoin):
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCoinCollectionViewCell.id, for: indexPath) as? TrendingCoinCollectionViewCell else { return UICollectionViewCell() }
//                
//                cell.configureData(data: trendingCoin.item)
//                
//                return cell
//            case let .trendingNFT(trendingNFT):
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingNFTCollectionViewCell.id, for: indexPath) as? TrendingNFTCollectionViewCell else { return UICollectionViewCell() }
//                
//                cell.configureData(data: trendingNFT)
//                
//                return cell
//            }
//        }
        
        let dataSource2 = RxCollectionViewSectionedReloadDataSource<MultipleSectionModel> { dataSource, collectionView, indexPath, item in
            switch item {
            case let .trendingCoin(trendingCoin):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCoinCollectionViewCell.id, for: indexPath) as? TrendingCoinCollectionViewCell else { return UICollectionViewCell() }
                
                cell.configureData(data: trendingCoin.item)
                
                return cell
            case let .trendingNFT(trendingNFT):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingNFTCollectionViewCell.id, for: indexPath) as? TrendingNFTCollectionViewCell else { return UICollectionViewCell() }
                
                cell.configureData(data: trendingNFT)
                
                return cell
            }
        } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
            switch kind {
            case SectionHeader.elementKind:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else { return SectionHeader() }
                        
                        switch dataSource[indexPath.section] {
                        case .trendingCoin(items: _):
                            header.bind(sectionTitle: "첫번째 섹션")
                        case .trendingNFT(items: _):
                            header.bind(sectionTitle: "두번째 섹션")
                        }
                return header
            default:
                return UICollectionReusableView()
            }
        }

        
        output.layout
            .drive(coinInfoView.infoCollectionView.rx.items(dataSource: dataSource2))
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
        coinInfoView.infoCollectionView.register(TrendingCoinCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCoinCollectionViewCell.id)
        
        coinInfoView.infoCollectionView.register(TrendingNFTCollectionViewCell.self, forCellWithReuseIdentifier: TrendingNFTCollectionViewCell.id)
        
        coinInfoView.infoCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: SectionHeader.elementKind, withReuseIdentifier: SectionHeader.identifier)
    }
}
