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
    
    var saveData: ((String) -> Void)?
    var deleteData: ((String) -> Void)?
    var disposBag = DisposeBag()
    var queryText = BehaviorRelay(value: "")
    
    private let searchData = PublishRelay<[CoinData]>()
    private let repository: StarItemRepository = StarItemTableRepository()
    
    struct Input {
        let viewWillAppear: Observable<Bool>
        let backButtonTapped: ControlEvent<Void>
        let textFieldReturnTapped: ControlEvent<Void>
        let textFieldText: ControlProperty<String>
        let modelSelected: ControlEvent<CoinData>
    }
    
    struct Output {
        let viewWillAppear: Driver<Bool>
        let queryText: Driver<String>
        let errorMessage: Driver<String>
        let searchData: Driver<[CoinData]>
        let backButtonTapped: Driver<Void>
        let modelSelected: Driver<CoinData>
    }
    
    func transform(input: Input) -> Output {
        
        repository.getFileURL()
        
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
        
        let validation = input.textFieldReturnTapped
            .withLatestFrom(input.textFieldText)
            .map { text in
                let trimmingText = text.trimmingCharacters(in: .whitespaces)
                if trimmingText.count < 1 {
                    return (false, trimmingText)
                } else {
                    return (true, trimmingText)
                }
            }
        
        validation
            .bind(with: self) { owner, value in
                if value.0 {
                    owner.queryText.accept(value.1)
                } else {
                    return
                }
            }
            .disposed(by: disposBag)
        
        return Output(
            viewWillAppear: input.viewWillAppear.asDriver(onErrorJustReturn: true),
            queryText: queryText.asDriver(),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: ""),
            searchData: searchData.asDriver(onErrorJustReturn: []),
            backButtonTapped: input.backButtonTapped.asDriver(),
            modelSelected: input.modelSelected.asDriver()
        )
    }
}
