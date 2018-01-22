//
//  TaskModel.swift
//  RealmExample
//
//  Created by 이광용 on 2018. 1. 22..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var name = ""
    @objc dynamic var content = ""
    @objc dynamic var createdDate = NSDate()
}
