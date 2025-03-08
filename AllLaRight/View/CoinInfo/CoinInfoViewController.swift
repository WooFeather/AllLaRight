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
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.id, for: indexPath) as? SectionHeader else { return SectionHeader() }
                        
                        switch dataSource[indexPath.section] {
                        case .trendingCoin(items: _):
                            // TODO: 날짜데이터 네트워크 요청시각으로 변경(output데이터에 바인딩)
                            header.configureData(sectionTitle: "인기 검색어", dateString: Date().toString())
                        case .trendingNFT(items: _):
                            header.configureData(sectionTitle: "인기 NFT", dateString: "")
                        }
                return header
            default:
                return UICollectionReusableView()
            }
        }
        
        output.infoData
            .drive(coinInfoView.infoCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // TODO: modelSelected 어떻게 처리할까
        coinInfoView.infoCollectionView.rx.itemSelected
            .bind(with: self) { owner, index in
                if index.section == 0 {
                    print(index.row)
                }
            }
            .disposed(by: disposeBag)
        
//        Observable.zip(coinInfoView.infoCollectionView.rx.modelSelected(MockTrendingCoinItem.self), coinInfoView.infoCollectionView.rx.itemSelected)
//            .bind(with: self) { owner, value in
//                if value.1.section == 0 {
//                    print(value.0)
//                }
//            }
//            .disposed(by: disposeBag)
        
//        coinInfoView.infoCollectionView.rx.modelSelected(MockTrendingCoinDetails.self)
//            .bind(with: self) { owner, data in
//                print(data.coinId)
//            }
//            .disposed(by: disposeBag)
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
        
        coinInfoView.infoCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: SectionHeader.elementKind, withReuseIdentifier: SectionHeader.id)
    }
}
