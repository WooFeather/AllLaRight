//
//  TrendingData.swift
//  AllLaRight
//
//  Created by 조우현 on 3/8/25.
//

import Foundation

struct TrendingData: Decodable {
    let coins: [TrendingCoinItem]
    let nfts: [TrendingNFTItem]
}

struct TrendingCoinItem: Decodable {
    let item: TrendingCoinDetails
}

struct TrendingCoinDetails: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    let score: Int
    let data: TrendingCoinData
}

struct TrendingCoinData: Decodable {
    let priceChangePercentage24h: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}

struct TrendingNFTItem: Decodable {
    let name: String
    let thumb: String
    let floorPrice24hPercentageChange: Double
    let data: TrendingNFTData
    
    enum CodingKeys: String, CodingKey {
        case name
        case thumb
        case floorPrice24hPercentageChange = "floor_price_24h_percentage_change"
        case data
    }
}

struct TrendingNFTData: Decodable {
    let floorPrice: String
    
    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
    }
}
