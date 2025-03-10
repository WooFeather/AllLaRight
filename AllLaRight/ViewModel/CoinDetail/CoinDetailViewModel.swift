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
                
                let chartSection = CoinDetailSectionModel.detailChart(header: nil, items: $0)
                
                let priceSection = CoinDetailSectionModel.detailChart(header: "두 번째 섹션", items: $0)
                
                let investmentSection = CoinDetailSectionModel.detailChart(header: "세 번째 섹션", items: $0)
                
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
    case detailChart(header: String?, items: [Item])
    case detailPrice(header: String?, items: [Item])
    case detailInvestment(header: String?, items: [Item])
}

extension CoinDetailSectionModel: SectionModelType {
    typealias Item = DetailData
    
    var items: [DetailData] {
        switch self {
        case .detailChart(_, let items):
            return items.map{ $0 }
        case .detailPrice(_, let items):
            return items.map{ $0 }
        case .detailInvestment(_, let items):
            return items.map{ $0 }
        }
    }
    
    init(original: CoinDetailSectionModel, items: [DetailData]) {
        switch original {
        case .detailChart(let header, let items):
            self = .detailChart(header: header, items: items)
        case .detailPrice(let header, let items):
            self = .detailPrice(header: header, items: items)
        case .detailInvestment(let header, let items):
            self = .detailInvestment(header: header, items: items)
        }
    }
}
