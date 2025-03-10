//
//  String+.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import Foundation

extension String {
    subscript(idx: Int) -> String? {
        guard (0..<count).contains(idx) else {
            return nil
        }
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
    
    func reversedJoin() -> String {
        return self.components(separatedBy: "-").reversed().joined(separator: "/")
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
}
