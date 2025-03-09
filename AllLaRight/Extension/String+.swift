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
}
