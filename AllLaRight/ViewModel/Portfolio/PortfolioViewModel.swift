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
    
    var id = BehaviorRelay(value: "") // TODO: id를 배열로 받도록 수정
    
    struct Input {
        let viewWillAppear: Observable<Bool>
    }
    
    struct Output {
        let portfolioData: Driver<[DetailData]>
    }
    
    func transform(input: Input) -> Output {
        let errorMessage = PublishRelay<String>()
        
        input.viewWillAppear
            .bind(with: self) { owner, _ in
                let data = Array(owner.repository.fetchAll())
                for element in data {
                    element.id // TODO: 배열에 추가
                }
            }
            .disposed(by: disposBag)
        
        id.flatMap {
            NetworkManager.shared.callAPI(api: .coingeckoMarket(id: $0), type: [DetailData].self)
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
