//
//  MarketViewModel.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class MarketViewModel: BaseViewModel {
    var disposBag = DisposeBag()
    
    private let marketList = PublishRelay<[MarketData]>()
    
    struct Input {
        let viewWillAppear: Observable<Bool>
        let viewWillDisappear: Observable<Bool>
    }
    
    struct Output {
        let marketList: Driver<[MarketData]>
        let errorMessage: Driver<String>
    }
    
    deinit {
        print("MarketViewModel Deinit")
    }
    
    func transform(input: Input) -> Output {
        
        let errorMessage = PublishRelay<String>()
        
        // TODO: 5초간격으로 방출할 수 있도록 intervar로 수정
        input.viewWillAppear
            .flatMap { _ in
                NetworkManager.shared.callAPI(api: .upbitMarket, type: [MarketData].self)
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
                        
                        return Single.just([])
                    }
            }
            .bind(with: self) { owner, data in
                owner.marketList.accept(data)
            }
            .disposed(by: disposBag)
        
        return Output(
            marketList: marketList.asDriver(onErrorJustReturn: []),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: "")
        )
    }
}
