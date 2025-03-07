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
        
    }
    
    struct Output {
        let marketList: Driver<[MarketData]>
    }
    
    deinit {
        print("MarketViewModel Deinit")
    }
    
    func transform(input: Input) -> Output {
        
        // TODO: Input에 flatmap으로 수정
        // TODO: 5초간격으로 방출할 수 있도록 intervar로 수정
        // TODO: Catch문으로 에러처리
        NetworkManager.shared.callAPI(api: .upbitMarket, type: [MarketData].self)
            .subscribe(with: self) { owner, data in
                owner.marketList.accept(data)
            }
            .disposed(by: disposBag)
        
        return Output(marketList: marketList.asDriver(onErrorJustReturn: []))
    }
}
