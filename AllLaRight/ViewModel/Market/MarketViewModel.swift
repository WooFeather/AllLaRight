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
    
    private let marketList = PublishRelay<[UpbitMarket]>()
    
    struct Input {
        
    }
    
    struct Output {
        let marketList: Driver<[UpbitMarket]>
    }
    
    deinit {
        print("MarketViewModel Deinit")
    }
    
    func transform(input: Input) -> Output {
        
        // TODO: Input에 flatmap으로 수정
        NetworkManager.shared.callUpbitMarketAPI(api: .upbitMarket)
            .subscribe(with: self) { owner, data in
                owner.marketList.accept(data)
            }
            .disposed(by: disposBag)
        
        return Output(marketList: marketList.asDriver(onErrorJustReturn: []))
    }
}
