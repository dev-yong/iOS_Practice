//
//  BoardService.swift
//  SoptSeminar7
//
//  Created by ganghoon oh on 2017. 12. 2..
//  Copyright © 2017년 kanghoon. All rights reserved.
//

import Foundation
import Alamofire

struct BoardService:APIServiece {
    static func getBoardData(code: String,
                             url: String,
                             method: HTTPMethod,
                             parameter: [String: Any]?,
                             completion: @escaping (DataResponse<Data>)->())
    {
        Alamofire.request(self.getURL(url), method: method, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseData(){(response) in
            
        }
    }
}
