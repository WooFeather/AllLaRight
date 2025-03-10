//
//  SearchData.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import Foundation

struct SearchData: Decodable {
    let coins: [CoinData]
}

struct CoinData: Decodable {
    let id: String
    let name: String
    let symbol: String
    let marketCapRank: Int?
    let large: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case marketCapRank = "market_cap_rank"
        case large
    }
}
