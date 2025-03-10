//
//  CoinSearchViewModel.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import Foundation
import RxSwift
import RxCocoa

final class CoinSearchViewModel: BaseViewModel {
    
    var disposBag = DisposeBag()
    var queryText = BehaviorRelay(value: "")
    
    private let searchData = PublishRelay<[CoinData]>()
    
    struct Input {
        
    }
    
    struct Output {
        let queryText: Driver<String>
        let errorMessage: Driver<String>
        let searchData: Driver<[CoinData]>
    }
    
    func transform(input: Input) -> Output {
        
        let errorMessage = PublishRelay<String>()
        
        queryText
            .distinctUntilChanged()
            .flatMap {
                NetworkManager.shared.callAPI(api: .coingeckoSearch(query: $0), type: SearchData.self)
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
                        
                        return Single.just(SearchData(coins: []))
                    }
            }
            .bind(with: self) { owner, data in
                owner.searchData.accept(data.coins)
            }
            .disposed(by: disposBag)
        
        return Output(
            queryText: queryText.asDriver(),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: ""),
            searchData: searchData.asDriver(onErrorJustReturn: [])
        )
    }
}
