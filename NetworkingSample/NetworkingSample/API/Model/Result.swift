//
//  Result.swift
//  UPAYm
//
//  Created by 이광용 on 2018. 9. 17..
//  Copyright © 2018년 UMS. All rights reserved.
//

import Foundation
import ObjectMapper

//class APIResult<T: Mappable>: Mappable {
//    var status: Int = 0
//    var message: String?
//    var code: Int = 0
//    var result: T?
//    
//    func mapping(map: Map) {
//        status  <- map["httpStatus"]
//        message <- map["message"]
//        code    <- map["responseCode"]
//        result  <- map["data"]
//    }
//    
//    required init?(map: Map) {
//        self.mapping(map: map)
//    }
//}
//
//class APIResultCollection<T: Mappable>: Mappable {
//    var status: Int = 0
//    var message: String?
//    var code: Int = 0
//    var resultCollection: [T]?
//    
//    func mapping(map: Map) {
//        status              <- map["httpStatus"]
//        message             <- map["message"]
//        code                <- map["responseCode"]
//        resultCollection    <- map["data"]
//    }
//    
//    required init?(map: Map) {
//        self.mapping(map: map)
//    }
//}
