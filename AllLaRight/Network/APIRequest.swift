//
//  APIRequest.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import Foundation
import Alamofire

enum APIRequest {
    case upbitMarket
    case coingeckoMarket
    case coingeckoTrending
    case coingeckoSearch(query: String)
    
    private var upbitBaseURL: String {
        return "https://api.upbit.com/v1/"
    }
    
    private var coingeckoBaseURL: String {
        return "https://api.coingecko.com/api/v3/"
    }
    
    var endpoint: URL {
        switch self {
        case .upbitMarket:
            return URL(string: upbitBaseURL + "ticker/all?quote_currencies=KRW")!
        case .coingeckoMarket:
            return URL(string: coingeckoBaseURL + "coins/markets?vs_currency=krw&sparkline=true")!
        case .coingeckoTrending:
            return URL(string: coingeckoBaseURL + "search/trending")!
        case .coingeckoSearch(let query):
            return URL(string: coingeckoBaseURL + "search?query=\(query)")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
