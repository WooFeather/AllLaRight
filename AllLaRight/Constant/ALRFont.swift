//
//  ALRFont.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit

enum ALRFont {
    case headlineBold
    case headline
    case bodyBold
    case body
    
    var font: UIFont {
        switch self {
        case .headlineBold:
            return UIFont.boldSystemFont(ofSize: 12)
        case .headline:
            return UIFont.systemFont(ofSize: 12)
        case .bodyBold:
            return UIFont.boldSystemFont(ofSize: 9)
        case .body:
            return UIFont.systemFont(ofSize: 9)
        }
    }
}
