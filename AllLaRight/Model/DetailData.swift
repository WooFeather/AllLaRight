//
//  DetailData.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import Foundation

struct DetailData: Decodable {
    let id: String
    let currentPrice: Double // 현재가
    let marketCap: Double // 시가총액
    let fullyDilutedValuation: Double? // 완전희석가치
    let totalVolume: Double // 총 거래량
    let high24h: Double? // 24시간 저가
    let low24h: Double? // 24시간 고가
    let priceChangePercentage24h: Double? // 24시간 변동폭
    let ath: Double // 사상 최고가(신고점)
    let athDate: String // 신고점 일자
    let atl: Double // 사상 최저가(신저점)
    let atlDate: String // 신저점 일자
    let lastUpdated: String // 최근 업데이트 시간
    let sparklineIn7d: SparklineData?
    
    enum CodingKeys: String, CodingKey {
        case id
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case ath
        case athDate = "ath_date"
        case atl
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7d = "sparkline_in_7d"
    }
}

struct SparklineData: Decodable {
    let price: [Double] // 일주일간 코인 시세
}
