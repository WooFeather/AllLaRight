//
//  Date+.swift
//  AllLaRight
//
//  Created by 조우현 on 3/8/25.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "MM.dd HH:mm 기준"
        return dateFormatter.string(from: self)
    }
}
