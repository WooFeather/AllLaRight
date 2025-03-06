//
//  NetworkManager.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    // TODO: 제네릭 적용한 메서드로 구현
//    func callAPI<T: Decodable>(api: APIRequest, type: T.Type) -> Single<T> {
//        return Signal<T.Type>.create { value in
//            
//            
//            return Disposables.create {
//                print("🗑️ Disposed")
//            }
//        }
//    }
    
    func callUpbitMarketAPI(api: APIRequest) -> Single<[UpbitMarket]> {
        return Single.create { value in
            
            AF.request(api.endpoint, method: api.method)
                .validate(statusCode: 200..<299)
                .responseDecodable(of: [UpbitMarket].self) { response in
                    switch response.result {
                    case .success(let data):
                        print("✅ SUCCESS", api.endpoint)
                        print("🙋‍♀️ STATUS CODE \(response.response?.statusCode ?? 000)")
                        value(.success(data))
                    case .failure(let error):
                        print("❌ FAILURE \(error)")
                        print("🙋‍♀️ STATUS CODE \(response.response?.statusCode ?? 000)")
                        value(.failure(error))
                    }
                }
            
            return Disposables.create {
                print("🗑️ Disposed")
            }
        }
    }
}
