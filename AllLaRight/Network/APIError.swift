//
//  APIError.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import Foundation

enum APIError: Error {
    case badRequest // 400
    case unauthorized // 401 => 여기까지 업비트, Coingeckco 동일
    case forbidden // 403 => 여기부터 Coingecko에서만 사용
    case tooManyRequests // 429
    case internalServerError // 500
    case serviceUnavailable // 503
    case accessDenied // 1020
    case apiKeyMissing // 10002
    case planError // 10005
    case corsError // CORS
    case unknownError
    
    var errorMessage: String {
        switch self {
        case .badRequest:
            return "잘못된 API요청입니다. 파라미터 값을 확인해주세요."
        case .unauthorized:
            return "인증되지 않은 사용자입니다. API Key를 확인해주세요."
        case .forbidden:
            return "허용되지 않은 엑세스입니다."
        case .tooManyRequests:
            return "API 요청 횟수를 초과했습니다."
        case .internalServerError:
            return "서버 오류입니다."
        case .serviceUnavailable:
            return "현재 서비스를 이용할 수 없습니다. API 상태를 확인해주세요."
        case .accessDenied:
            return "CND 방화벽 규칙 위반으로 인한 접근 불가 상태입니다."
        case .apiKeyMissing:
            return "잘못된 API Key입니다."
        case .planError:
            return "유료 API에서 사용할 수 있는 기능입니다."
        case .corsError:
            return "CORS 헤더 오류입니다."
        case .unknownError:
            return "알 수 없는 에러가 발생했습니다. 다시 시도해주세요."
        }
    }
}
