//
//  Album.swift
//  RealmExample
//
//  Created by 이광용 on 2018. 1. 22..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation
import RealmSwift

class Album: Object {
    static var realm: Realm {
        return try! Realm()
    }

    @objc dynamic var title: String = ""
    @objc dynamic var saveDate: Date = Date()
    @objc var uuid: String = UUID().uuidString
    let photos: List<Photo> = List<Photo>()
    
    override static func primaryKey() -> String? {
        return "uuid"
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

class Photo: Object {
    @objc dynamic var saveDate: Date = Date()
    @objc dynamic var imageData: Data = Data() 
}
