//
//  Double+.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import Foundation

extension Double {
    // 소수점 두 번째 자리까지 반올림해서 String으로 반환
    func toPercentString() -> String {
        return String(format: "%.2f", self * 100) + "%"
    }
    
    // 백만으로 분기처리 할 경우 스트링
    func toMillionString() -> String {
        return trunc(self / 1000000).formatted() + "백만"
    }
    
    func toABSString() -> String {
        return String(format: "%.2f", abs(self)) + "%"
    }
    
    func toPriceString() -> String {
        let stringArray = Array(String(format: "%.2f", self))
        let dotIndex = stringArray.firstIndex(of: ".") ?? 999
        let afterDotString = (String(format: "%.2f", self)[dotIndex + 2] ?? "")
        
        if afterDotString == "0" {
            return Double(String(format: "%.1f", self))?.formatted() ?? "0.0"
        } else {
            return Double(String(format: "%.2f", self))?.formatted() ?? "0.0"
        }
    }
}
