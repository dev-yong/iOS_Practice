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
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 2,
                                                                       migrationBlock : { migration, oldSchemaVersion in
                                                                        if oldSchemaVersion < 1 {
                                                                            migration.renameProperty(onType: self.className(), from: "phoneNumeber", to: "phone")
                                                                            migration.enumerateObjects(ofType: self.className(), { (_, newObject) in
                                                                                newObject?["migration"] = 1
                                                                            })
                                                                        }
                                                                        if oldSchemaVersion < 2 {
                                                                            migration.enumerateObjects(ofType: Contact.className(), { (oldObject, newObject) in
                                                                                let name = oldObject?["name"] as! String
                                                                                let phone = oldObject?["phone"] as! String
                                                                                newObject?["name_Phone"] = "\(name) (\(phone))"
                                                                            })
                                                                        }
        })
        return try! Realm()
    }
    @objc dynamic var personID: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = "" //schemaVersion 1 : phoneNumeber -> phone
    @objc dynamic var birthDay: Date?
    @objc dynamic var migration: Int = 1 // schemaVersion 1 : add property
    @objc dynamic var name_Phone: String = ""// schemaVersion 2 : add property
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




