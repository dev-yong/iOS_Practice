//
//  APIService.swift
//  UPAYm
//
//  Created by 이광용 on 2018. 9. 17..
//  Copyright © 2018년 UMS. All rights reserved.
//

import Foundation
import Alamofire

protocol APIService {
    var path: String {get}
    var parameters: Parameters? {get}
    var method: HTTPMethod {get}
    var header: HTTPHeaders? {get}
}

