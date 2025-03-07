//
//  Double+.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import Foundation

extension Double {
    // 소수점 두 번째 자리까지 반올림해서 String으로 반환
    func toFormattedString() -> String {
        return String(format: "%.2f", self)
    }
}
