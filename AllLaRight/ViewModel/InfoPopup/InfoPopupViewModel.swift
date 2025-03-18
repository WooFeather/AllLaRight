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
    
    var errorMessage = BehaviorRelay(value: "네트워크 연결이 일시적으로 원활하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요.")
    
    struct Input {
        let retryButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let errorMessage: Driver<String>
        let retryButtonTapped: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        // TODO: retryButtonTap시 네트워크 재시도
        
        return Output(
            errorMessage: errorMessage.asDriver(),
            retryButtonTapped: input.retryButtonTapped.asDriver()
        )
    }
}
