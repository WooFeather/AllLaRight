//
//  MarketViewModel.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa
import RxGesture

final class MarketViewModel: BaseViewModel {
    enum SortState {
        case desc
        case asc
        case none
    }
    
    var disposBag = DisposeBag()
    var timerDisposeBag = DisposeBag()
    
    private let marketList = PublishRelay<[MarketData]>()
    
    private let currentPriceState = BehaviorRelay<SortState>(value: .none)
    private let compareToPreviousDayState = BehaviorRelay<SortState>(value: .none)
    private let tradePriceState = BehaviorRelay<SortState>(value: .none)
    
    struct Input {
        let currentPriceViewTapped: TapControlEvent
        let compareToPreviousDayViewTapped: TapControlEvent
        let tradePriceViewTapped: TapControlEvent
    }
    
    struct Output {
        let marketList: Driver<[MarketData]>
        let errorMessage: Driver<String>
        let currentPriceViewState: Driver<SortState>
        let compareToPreviousDayViewState: Driver<SortState>
        let tradePriceViewState: Driver<SortState>
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
        
        apiTimer
            .bind(with: self) { owner, data in
                owner.marketList.accept(data)
            }
            .disposed(by: timerDisposeBag)
        
        input.currentPriceViewTapped
            .when(.recognized)
            .bind(with: self) { owner, _ in
                owner.compareToPreviousDayState.accept(.none)
                owner.tradePriceState.accept(.none)
                if owner.currentPriceState.value == .none {
                    owner.currentPriceState.accept(.desc)
                } else if owner.currentPriceState.value == .desc {
                    owner.currentPriceState.accept(.asc)
                } else {
                    owner.currentPriceState.accept(.none)
                }
            }
            .disposed(by: disposBag)
        
        currentPriceState
            .bind(with: self) { owner, state in
                switch state {
                case .desc:
                    owner.timerDisposeBag = DisposeBag()
                    apiTimer
                        .bind(with: self) { owner, data in
                           let sortedData = data.sorted { $0.currentPrice > $1.currentPrice }
                            owner.marketList.accept(sortedData)
                        }
                        .disposed(by: owner.timerDisposeBag)
                case .asc:
                    owner.timerDisposeBag = DisposeBag()
                    apiTimer
                        .bind(with: self) { owner, data in
                           let sortedData = data.sorted { $0.currentPrice < $1.currentPrice }
                            owner.marketList.accept(sortedData)
                        }
                        .disposed(by: owner.timerDisposeBag)
                case .none:
                    owner.timerDisposeBag = DisposeBag()
                    apiTimer
                        .bind(with: self) { owner, data in
                            owner.marketList.accept(data)
                        }
                        .disposed(by: owner.timerDisposeBag)
                }
            }
            .disposed(by: disposBag)
        
        input.compareToPreviousDayViewTapped
            .when(.recognized)
            .bind(with: self) { owner, _ in
                owner.currentPriceState.accept(.none)
                owner.tradePriceState.accept(.none)
                if owner.compareToPreviousDayState.value == .none {
                    owner.compareToPreviousDayState.accept(.desc)
                } else if owner.compareToPreviousDayState.value == .desc {
                    owner.compareToPreviousDayState.accept(.asc)
                } else {
                    owner.compareToPreviousDayState.accept(.none)
                }
            }
            .disposed(by: disposBag)
        
        compareToPreviousDayState
            .bind(with: self) { owner, state in
                switch state {
                case .desc:
                    owner.timerDisposeBag = DisposeBag()
                    apiTimer
                        .bind(with: self) { owner, data in
                            let sortedData = data.sorted { $0.changeRate > $1.changeRate }
                            owner.marketList.accept(sortedData)
                        }
                        .disposed(by: owner.timerDisposeBag)
                case .asc:
                    owner.timerDisposeBag = DisposeBag()
                    apiTimer
                        .bind(with: self) { owner, data in
                           let sortedData = data.sorted { $0.changeRate < $1.changeRate }
                            owner.marketList.accept(sortedData)
                        }
                        .disposed(by: owner.timerDisposeBag)
                case .none:
                    owner.timerDisposeBag = DisposeBag()
                    apiTimer
                        .bind(with: self) { owner, data in
                            owner.marketList.accept(data)
                        }
                        .disposed(by: owner.timerDisposeBag)
                }
            }
            .disposed(by: disposBag)
        
        input.tradePriceViewTapped
            .when(.recognized)
            .bind(with: self) { owner, _ in
                owner.currentPriceState.accept(.none)
                owner.compareToPreviousDayState.accept(.none)
                if owner.tradePriceState.value == .none {
                    owner.tradePriceState.accept(.desc)
                } else if owner.tradePriceState.value == .desc {
                    owner.tradePriceState.accept(.asc)
                } else {
                    owner.tradePriceState.accept(.none)
                }
            }
            .disposed(by: disposBag)
        
        tradePriceState
            .bind(with: self) { owner, state in
                switch state {
                case .desc:
                    owner.timerDisposeBag = DisposeBag()
                    apiTimer
                        .bind(with: self) { owner, data in
                            let sortedData = data.sorted { $0.tradePrice24 > $1.tradePrice24 }
                            owner.marketList.accept(sortedData)
                        }
                        .disposed(by: owner.timerDisposeBag)
                case .asc:
                    owner.timerDisposeBag = DisposeBag()
                    apiTimer
                        .bind(with: self) { owner, data in
                           let sortedData = data.sorted { $0.tradePrice24 < $1.tradePrice24 }
                            owner.marketList.accept(sortedData)
                        }
                        .disposed(by: owner.timerDisposeBag)
                case .none:
                    owner.timerDisposeBag = DisposeBag()
                    apiTimer
                        .bind(with: self) { owner, data in
                            owner.marketList.accept(data)
                        }
                        .disposed(by: owner.timerDisposeBag)
                }
            }
            .disposed(by: disposBag)
        
        return Output(
            marketList: marketList.asDriver(onErrorJustReturn: []),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: ""),
            currentPriceViewState: currentPriceState.asDriver(),
            compareToPreviousDayViewState: compareToPreviousDayState.asDriver(),
            tradePriceViewState: tradePriceState.asDriver()
        )
    }
}
