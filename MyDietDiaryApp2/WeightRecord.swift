//
//  WeightRecord.swift
//  MyDietDiaryApp2
//
//  Created by 橋本純一 on 2021/12/04.
//

import Foundation
import RealmSwift

class WeightRecord: Object {
    override static func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var weight: Double = 0
}
