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
    
    var disposBag = DisposeBag()
    var queryText = BehaviorRelay(value: "")
    
    struct Input {
        
    }
    
    struct Output {
        let queryText: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        return Output(queryText: queryText.asDriver())
    }
}
