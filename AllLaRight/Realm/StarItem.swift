//
//  StarItem.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import Foundation
import RealmSwift

final class StarItem: Object {
    @Persisted(primaryKey: true) var id: String
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}
