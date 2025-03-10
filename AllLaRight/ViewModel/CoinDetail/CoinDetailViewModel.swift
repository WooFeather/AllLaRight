//
//  CoinDetailViewModel.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import Foundation
import RxSwift
import RxCocoa

final class CoinDetailViewModel: BaseViewModel {
    var disposBag = DisposeBag()
    
    var id = BehaviorRelay(value: "")
    var imageUrl = BehaviorRelay(value: "")
    var symbolText = BehaviorRelay(value: "")
    
    struct Input {
        
    }
    
    struct Output {
        let imageUrl: Driver<String>
        let symbolText: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        return Output(
            imageUrl: imageUrl.asDriver(),
            symbolText: symbolText.asDriver()
        )
    }
}
