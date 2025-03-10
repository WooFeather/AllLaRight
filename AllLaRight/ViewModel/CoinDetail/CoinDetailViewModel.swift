//
//  CoinDetailViewModel.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class CoinDetailViewModel: BaseViewModel {
    var disposBag = DisposeBag()
    
    var id = BehaviorRelay(value: "")
    var imageUrl = BehaviorRelay(value: "")
    var symbolText = BehaviorRelay(value: "")
    
    private let detailData = PublishRelay<[DetailData]>()
    private var detailInfoData: Observable<[CoinDetailSectionModel]> {
        return detailData
            .map{
                var sections: [CoinDetailSectionModel] = []
                
                let chartSection = CoinDetailSectionModel.detailChart(items: $0)
                
                let priceSection = CoinDetailSectionModel.detailChart(items: $0)
                
                let investmentSection = CoinDetailSectionModel.detailChart(items: $0)
                
                sections.append(contentsOf: [chartSection, priceSection, investmentSection])
                
                return sections
            }
    }
    
    struct Input {
        let backButtonTapped: ControlEvent<Void>
        let starButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let imageUrl: Driver<String>
        let symbolText: Driver<String>
        let backButtonTapped: Driver<Void>
        let starButtonTapped: Driver<Void>
        let errorMessage: Driver<String>
        let detailInfoData: Driver<[CoinDetailSectionModel]>
    }
    
    func transform(input: Input) -> Output {
        
        let errorMessage = PublishRelay<String>()
        
        id
            .flatMap {
                NetworkManager.shared.callAPI(api: .coingeckoMarket(id: $0), type: [DetailData].self)
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
                owner.detailData.accept(data)
            }
            .disposed(by: disposBag)
        
        return Output(
            imageUrl: imageUrl.asDriver(),
            symbolText: symbolText.asDriver(),
            backButtonTapped: input.backButtonTapped.asDriver(),
            starButtonTapped: input.starButtonTapped.asDriver(),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: ""),
            detailInfoData: detailInfoData.asDriver(onErrorJustReturn: [])
        )
    }
}

// MARK: - RxDataSource Setting

enum CoinDetailSectionModel {
    case detailChart(items: [Item])
    case detailPrice(items: [Item])
    case detailInvestment(items: [Item])
}

extension CoinDetailSectionModel: SectionModelType {
    typealias Item = DetailData
    
    var items: [DetailData] {
        switch self {
        case .detailChart(let items):
            return items.map{ $0 }
        case .detailPrice(let items):
            return items.map{ $0 }
        case .detailInvestment(let items):
            return items.map{ $0 }
        }
    }
    
    init(original: CoinDetailSectionModel, items: [DetailData]) {
        switch original {
        case .detailChart(let items):
            self = .detailChart(items: items)
        case .detailPrice(let items):
            self = .detailPrice(items: items)
        case .detailInvestment(let items):
            self = .detailInvestment(items: items)
        }
    }
}
