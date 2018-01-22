//
//  ContactModel.swift
//  RealmExample
//
//  Created by 이광용 on 2018. 1. 22..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


class Contact: Object {
    static var realm: Realm {
        return try! Realm()
    }
    @objc dynamic var personID: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var phoneNumeber: String = ""
    @objc dynamic var birthDay: Date?
    

    ///Primary Key를 등록해 줍니다.
    override static func primaryKey() -> String? {
        return "personID"
    }
    
    static func addToRealm<T: Object>(_ item: T) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    static func removeFromRealm<T:Object>(_ item: T) {
        try! realm.write {
            realm.delete(item)
        }
    }
    
    static func removeFromAllRealm() {
        let realm: Realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}




