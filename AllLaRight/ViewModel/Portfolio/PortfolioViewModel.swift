//
//  PortfolioViewModel.swift
//  AllLaRight
//
//  Created by 조우현 on 4/30/25.
//

import Foundation
import RxSwift
import RxCocoa

final class PortfolioViewModel: BaseViewModel {
    var disposBag = DisposeBag()
    
    private let repository: StarItemRepository = StarItemTableRepository()
    private let portfolioData = PublishRelay<[DetailData]>()
    
    var ids = BehaviorRelay<[String]>(value: [])
    
    struct Input {
        let viewWillAppear: Observable<Bool>
    }
    
    struct Output {
        let portfolioData: Driver<[DetailData]>
    }
    
    func transform(input: Input) -> Output {
        let errorMessage = PublishRelay<String>()
        let mockData: [DetailData] = [
            DetailData(id: "movement", symbol: "move", name: "Movement", image: "https://coin-images.coingecko.com/coins/images/39345/large/movement-testnet-token.png?1721878759", currentPrice: 134844709, marketCap: 854705803052, fullyDilutedValuation: nil, totalVolume: 159106567899, high24h: 357.69, low24h: nil, priceChangePercentage24h: -11.908640033547613, ath: 2068.98, athDate: "2024-12-10T04:05:51.093Z", atl: 309.32, atlDate: "2025-04-20T18:40:54.556Z", lastUpdated:  "2025-04-30T14:59:20.080Z", sparklineIn7d: nil)
        ]
        
        input.viewWillAppear
            .bind(with: self) { owner, _ in
                let likeIds = Array(owner.repository.fetchAll().map(\.id))
                owner.ids.accept(likeIds)
            }
            .disposed(by: disposBag)
        
        ids
            .filter { !$0.isEmpty }
            .flatMapLatest {
                NetworkManager.shared.callAPI(api: .coingeckoMarket(ids: $0), type: [DetailData].self)
                    .retry(3)
                    .catch { error in
                        switch error as? APIError {
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
                        return Single.just([])
                    }
            }
            .bind(with: self) { owner, data in
                owner.portfolioData.accept(data)
            }
            .disposed(by: disposBag)
        
        
        return Output(
            portfolioData: portfolioData.asDriver(onErrorJustReturn: [])
        )
    }
}
