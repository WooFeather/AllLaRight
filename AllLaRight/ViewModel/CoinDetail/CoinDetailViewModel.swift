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
    
    private let repository: StarItemRepository = StarItemTableRepository()
    
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
        let viewWillAppear: Observable<Bool>
        let backButtonTapped: ControlEvent<Void>
        let starButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let imageUrl: Driver<String>
        let symbolText: Driver<String>
        let backButtonTapped: Driver<Void>
//        let starButtonTapped: Driver<Void>
        let errorMessage: Driver<String>
        let detailInfoData: Driver<[CoinDetailSectionModel]>
        let isStared: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let errorMessage = PublishRelay<String>()
        let isStared = PublishRelay<Bool>()
        
        id
            .flatMap {
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
                owner.detailData.accept(data)
            }
            .disposed(by: disposBag)
        
        input.starButtonTapped
            .bind(with: self) { owner, _ in
                let data = Array(owner.repository.fetchAll())
                let existingData = data.filter {
                    $0.id == owner.id.value
                }
                
                if existingData.count > 0 {
                    owner.repository.deleteItem(data: existingData.first ?? existingData[0])
                    isStared.accept(false)
                } else {
                    owner.repository.createItem(id: owner.id.value)
                    isStared.accept(true)
                }
            }
            .disposed(by: disposBag)
        
        input.viewWillAppear
            .bind(with: self) { owner, _ in
                let data = Array(owner.repository.fetchAll())
                let existingData = data.filter {
                    $0.id == owner.id.value
                }
                
                if existingData.count > 0 {
                    isStared.accept(true) // DB에 이미 추가돼있는 상태
                } else {
                    isStared.accept(false) // DB에 없는 상태
                }
            }
            .disposed(by: disposBag)
        
        return Output(
            imageUrl: imageUrl.asDriver(),
            symbolText: symbolText.asDriver(),
            backButtonTapped: input.backButtonTapped.asDriver(),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: ""),
            detailInfoData: detailInfoData.asDriver(onErrorJustReturn: []),
            isStared: isStared.asDriver(onErrorJustReturn: false)
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
