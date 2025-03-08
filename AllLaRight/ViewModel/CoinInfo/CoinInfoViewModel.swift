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
    
    private let trendingCoinData = PublishRelay<[TrendingCoinItem]>()
    private let trendingNFTData = PublishRelay<[TrendingNFTItem]>()
    
    private var trendingData: Observable<[MultipleSectionModel]> {
        return Observable.combineLatest(trendingCoinData, trendingNFTData)
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
        let modelSelected: ControlEvent<SectionItem>
    }
    
    struct Output {
        let trendingData: Driver<[MultipleSectionModel]>
        let errorMessage: Driver<String>
        let modelSelected: Driver<SectionItem>
    }
    
    deinit {
        print("CoinInfoViewModel Deinit")
    }
    
    func transform(input: Input) -> Output {
        
        let errorMessage = PublishRelay<String>()
        let timer = Observable<Int>.timer(.seconds(0), period: .seconds(600), scheduler: MainScheduler.instance)
        let networkTime = BehaviorRelay(value: Date())
        
        let apiTimer = timer
            .flatMap { _ in
                NetworkManager.shared.callAPI(api: .coingeckoTrending, type: TrendingData.self)
                    .retry(3)
                    .catch { error in
                        switch error as? APIError {
                        case .disconnection:
                            errorMessage.accept(APIError.disconnection.errorMessage)
                        case .badRequest:
                            errorMessage.accept(APIError.badRequest.errorMessage)
                        case .unauthorized:
                            errorMessage.accept(APIError.unauthorized.errorMessage)
                        case .forbidden:
                            errorMessage.accept(APIError.forbidden.errorMessage)
                        case .tooManyRequests:
                            errorMessage.accept(APIError.tooManyRequests.errorMessage)
                        case .internalServerError:
                            errorMessage.accept(APIError.internalServerError.errorMessage)
                        case .serviceUnavailable:
                            errorMessage.accept(APIError.serviceUnavailable.errorMessage)
                        case .accessDenied:
                            errorMessage.accept(APIError.accessDenied.errorMessage)
                        case .apiKeyMissing:
                            errorMessage.accept(APIError.apiKeyMissing.errorMessage)
                        case .planError:
                            errorMessage.accept(APIError.planError.errorMessage)
                        case .corsError:
                            errorMessage.accept(APIError.planError.errorMessage)
                        default:
                            errorMessage.accept(APIError.unknownError.errorMessage)
                        }
                        
                        return Single.just(TrendingData(coins: [], nfts: []))
                    }
            }
        
        apiTimer
            .bind(with: self) { owner, data in
                owner.trendingCoinData.accept(data.coins.filter{ $0.item.score < 14 })
                owner.trendingNFTData.accept(data.nfts)
                networkTime.accept(Date())
            }
            .disposed(by: disposBag)
        
        return Output(
            trendingData: trendingData.asDriver(onErrorJustReturn: []),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: ""),
            modelSelected: input.modelSelected.asDriver()
        )
    }
}

// MARK: - RxDataSource Setting

enum MultipleSectionModel {
    case trendingCoin(items: [SectionItem])
    case trendingNFT(items: [SectionItem])
}

enum SectionItem {
    case trendingCoin(trendingCoin: TrendingCoinItem)
    case trendingNFT(trendingNFT: TrendingNFTItem)
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
