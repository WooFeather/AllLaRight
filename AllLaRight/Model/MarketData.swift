//
//  UpbitMarket.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import Foundation

struct MarketData: Decodable {
    let coinName: String // 코인명
    let currentPrice: Double // 현재가
    let change: String // 상승, 하락, 보합
    let changePrice: Double // 변화액
    let changeRate: Double // 변화율
    let tradePrice: Double // 24시간 거래대금
    
    enum CodingKeys: String, CodingKey {
        case coinName = "market"
        case currentPrice = "trade_price"
        case change
        case changePrice = "signed_change_price"
        case changeRate = "signed_change_rate"
        case tradePrice = "acc_trade_price_24h"
    }
}
