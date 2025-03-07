//
//  CoinInfoViewModel.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import Foundation
import RxSwift
import RxCocoa

final class CoinInfoViewModel: BaseViewModel {
    var disposBag = DisposeBag()
    
    let mockTrendingCoinData: [MockTrendingCoinItem] = mockTrendingCoins
    let mockTrendingNFTData: [MockTrendingNFTItem] = mockTrendingNFTs
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
