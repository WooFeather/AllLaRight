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
    private let viewModel = CoinInfoViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    deinit {
        print("CoinInfoViewController Deinit")
    }

    // MARK: - Functions
    override func bind() {
        let input = CoinInfoViewModel.Input(
            modelSelected: coinInfoView.infoCollectionView.rx.modelSelected(SectionItem.self),
            textFieldReturnTapped: coinInfoView.searchTextField.textField.rx.controlEvent(.editingDidEndOnExit),
            textFieldText: coinInfoView.searchTextField.textField.rx.text.orEmpty
        )
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
                            header.configureData(sectionTitle: "인기 검색어", dateString: Date().toString())
                        case .trendingNFT(items: _):
                            header.configureData(sectionTitle: "인기 NFT", dateString: "")
                        }
                return header
            default:
                return UICollectionReusableView()
            }
        }
        
        output.trendingData
            .drive(coinInfoView.infoCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // TODO: 통신이 되기 전에는 인디케이터 표시
        
        // TODO: Error반환시 AlertView 띄우기
        // output.errorMessage
        
        output.modelSelected
            .drive(with: self) { owner, data in
                switch data {
                case .trendingCoin(trendingCoin: let trendingCoin):
                    print(trendingCoin.item.id)
                    
                    let vc = CoinDetailViewController()
                    owner.navigationController?.pushViewController(vc, animated: true)
                case .trendingNFT(trendingNFT: _):
                    break
                }
            }
            .disposed(by: disposeBag)
        
        Driver.zip(output.isTextValidate, output.queryText)
            .drive(with: self) { owner, value in
                if value.0 {
                    print(value.1)
                    let vc = CoinSearchViewController()
                    vc.viewModel.queryText.accept(value.1)
                    owner.navigationController?.pushViewController(vc, animated: true)
                    
                    owner.coinInfoView.searchTextField.textField.text = ""
                } else {
                    owner.coinInfoView.searchTextField.textField.text = ""
                    return
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - ConfigureView
    override func loadView() {
        view = coinInfoView
    }
    
    override func configureData() {
        coinInfoView.infoCollectionView.register(TrendingCoinCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCoinCollectionViewCell.id)
        
        coinInfoView.infoCollectionView.register(TrendingNFTCollectionViewCell.self, forCellWithReuseIdentifier: TrendingNFTCollectionViewCell.id)
        
        coinInfoView.infoCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: SectionHeader.elementKind, withReuseIdentifier: SectionHeader.id)
    }
}
