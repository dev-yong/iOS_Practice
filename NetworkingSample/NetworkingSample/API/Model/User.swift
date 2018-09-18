//
//  Model.swift
//  UPAYm
//
//  Created by 이광용 on 2018. 9. 17..
//  Copyright © 2018년 UMS. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable{
    var uuid: Int = -1
    var firstName: String = ""
    var lastName: String = ""
    var imageURLString: String?
    
    func mapping(map: Map) {
        uuid            <- map["id"]
        firstName       <- map["first_name"]
        lastName        <- map["last_name"]
        imageURLString  <- map["avatar"]
    }
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
}

class UserList: Mappable {
    var page: Int = -1
    var perPage: Int = -1
    var total: Int = -1
    var totalPage: Int = -1
    var users: [User]?

    func mapping(map: Map) {
        page        <- map["page"]
        perPage     <- map["per_page"]
        total       <- map["total"]
        totalPage   <- map["total_pages"]
        users       <- map["data"]
    }
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
}
