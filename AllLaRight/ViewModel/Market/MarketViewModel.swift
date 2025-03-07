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
    var timerDisposeBag = DisposeBag()
    
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
        let timer = Observable<Int>.timer(.seconds(0), period: .seconds(5), scheduler: MainScheduler.instance)
        
        let apiTimer = timer
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
        
        input.viewWillAppear
            .bind(with: self) { owner, _ in
                print("viewWillAppear")
                apiTimer
                    .bind(with: self) { owner, data in
                        owner.marketList.accept(data)
                    }
                    .disposed(by: owner.timerDisposeBag)
            }
            .disposed(by: disposBag)
        
        input.viewWillDisappear
            .bind(with: self) { owner, _ in
                print("viewWillDisappear")
                owner.timerDisposeBag = DisposeBag()
            }
            .disposed(by: disposBag)
        
        return Output(
            marketList: marketList.asDriver(onErrorJustReturn: []),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: "")
        )
    }
}
