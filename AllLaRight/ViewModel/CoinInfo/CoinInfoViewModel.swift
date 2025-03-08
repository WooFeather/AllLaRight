//
//  CoinInfoViewModel.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class CoinInfoViewModel: BaseViewModel {
    var disposBag = DisposeBag()
    
    private let mockTrendingCoinData = BehaviorRelay(value: mockTrendingCoins)
    private let mockTrendingNFTData = BehaviorRelay(value: mockTrendingNFTs)
    private var infoData: Observable<[MultipleSectionModel]> {
        return Observable.combineLatest(mockTrendingCoinData, mockTrendingNFTData)
            .map { coin, nft in
                var sections: [MultipleSectionModel] = []
                
                let coinItems = coin.map { SectionItem.trendingCoin(trendingCoin: $0) }
                let coinSection = MultipleSectionModel.trendingCoin(items: coinItems)
                sections.append(coinSection)
                
                let nftItems = nft.map { SectionItem.trendingNFT(trendingNFT: $0) }
                let nftSection = MultipleSectionModel.trendingNFT(items: nftItems)
                sections.append(nftSection)
                
                return sections
            }
    }
    
    struct Input {
        
    }
    
    struct Output {
        let infoData: Driver<[MultipleSectionModel]>
    }
    
    func transform(input: Input) -> Output {
        
        return Output(
            infoData: infoData.asDriver(onErrorJustReturn: [])
        )
    }
}

// MARK: - RxDataSource Setting

enum MultipleSectionModel {
    case trendingCoin(items: [SectionItem])
    case trendingNFT(items: [SectionItem])
}

enum SectionItem {
    case trendingCoin(trendingCoin: MockTrendingCoinItem)
    case trendingNFT(trendingNFT: MockTrendingNFTItem)
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch self {
        case .trendingCoin(let items):
            return items.map { $0 }
        case .trendingNFT(let items):
            return items.map { $0 }
        }
    }
    
    init(original: MultipleSectionModel, items: [SectionItem]) {
        switch original {
        case .trendingCoin(let items):
            self = .trendingCoin(items: items)
        case .trendingNFT(let items):
            self = .trendingNFT(items: items)
        }
    }
}
