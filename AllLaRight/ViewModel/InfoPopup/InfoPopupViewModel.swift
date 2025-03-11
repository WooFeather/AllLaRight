//
//  InfoPopupViewModel.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import Foundation
import RxSwift
import RxCocoa

final class InfoPopupViewModel: BaseViewModel {

    var disposBag = DisposeBag()
    
    var errorMessage = BehaviorRelay(value: "")
    
    struct Input {
        let retryButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let errorMessage: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        // TODO: retryButtonTap시 네트워크 재시도
        
        return Output(errorMessage: errorMessage.asDriver())
    }
}
