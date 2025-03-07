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
    
    func callAPI<T: Decodable>(api: APIRequest, type: T.Type) -> Single<T> {
        return Single.create { value in
            
            AF.request(api.endpoint, method: api.method)
                .validate(statusCode: 200..<299)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        print("✅ SUCCESS", api.endpoint)
                        print("🙋‍♀️ STATUS CODE \(response.response?.statusCode ?? 000)")
                        value(.success(data))
                    case .failure(let error):
                        print("❌ FAILURE \(error)")
                        print("🙋‍♀️ STATUS CODE \(response.response?.statusCode ?? 000)")
                        
                        let errorStatusCode = response.response?.statusCode
                        switch errorStatusCode {
                        case 400:
                            value(.failure(APIError.badRequest))
                        case 401:
                            value(.failure(APIError.unauthorized))
                        case 403:
                            value(.failure(APIError.forbidden))
                        case 429:
                            value(.failure(APIError.tooManyRequests))
                        case 500:
                            value(.failure(APIError.internalServerError))
                        case 503:
                            value(.failure(APIError.serviceUnavailable))
                        case 1020:
                            value(.failure(APIError.accessDenied))
                        case 10002:
                            value(.failure(APIError.apiKeyMissing))
                        case 10005:
                            value(.failure(APIError.planError))
                        default:
                            value(.failure(APIError.unknownError))
                        }
                    }
                }
            
            return Disposables.create {
                print("🗑️ Disposed")
            }
        }
    }
}
