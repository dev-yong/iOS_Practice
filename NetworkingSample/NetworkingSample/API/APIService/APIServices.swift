//
//  APIServices.swift
//  UPAYm
//
//  Created by 이광용 on 2018. 9. 17..
//  Copyright © 2018년 UMS. All rights reserved.
//

import Foundation
import Alamofire

enum UserService: APIService {
    case get(page: Int)
    case search(uuid: Int)
    
    var path: String {
        switch self {
        case .get(let page):
            return "/api/users?page=\(page)"
        case .search(let uuid):
            return "/api/users/\(uuid)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .get, .search:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get, .search:
            return .get
        }
    }
    
    var header: HTTPHeaders?{
        return nil
    }
}
