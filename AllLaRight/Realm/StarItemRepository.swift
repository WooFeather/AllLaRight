//
//  StarItemRepository.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import Foundation
import RealmSwift

protocol StarItemRepository {
    func getFileURL()
    func fetchAll() -> Results<StarItem>
    func createItem(id: String)
    func deleteItem(data: StarItem)
}

final class StarItemTableRepository: StarItemRepository {
    private let realm = try! Realm()
    
    func getFileURL() {
        print(realm.configuration.fileURL ?? "URL 찾을 수 없음")
    }
    
    func fetchAll() -> Results<StarItem> {
        let data = realm.objects(StarItem.self)
             .sorted(byKeyPath: "likeDate", ascending: false)
        
        return data
    }
    
    func createItem(id: String) {
        do {
            try realm.write {
                let data = StarItem(
                    id: id
                )
                
                realm.add(data)
            }
        } catch {
            print("realm 데이터 저장 실패")
        }
    }
    
    func deleteItem(data: StarItem) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("realm 데이터 삭제 실패")
        }
    }
}
