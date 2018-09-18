//
//  APIServiece.swift
//  SoptSeminar7
//
//  Created by 이광용 on 2017. 12. 2..
//  Copyright © 2017년 kanghoon. All rights reserved.
//

import Foundation
import Alamofire

protocol APIServiece{

}


extension APIServiece{
    static func getURL(_ path: String) -> String {
        return "http://220.230.114.8:3987/" + path
    }
    
    static func getStatusCodeAndResult(response: DataResponse<Data>) -> [String:Any?]?
    {
        switch response.result {
        case .success :
            guard let statusCode = response.response?.statusCode  else {return nil}
            guard let responseData = response.data else {return nil}
            var resultStatusData:[String: Any?] = ["code": statusCode, "data": nil]
            switch Int(statusCode)
            {
            case 200..<400:
                resultStatusData["data"] = responseData
                break
            default:
                break
            }
            return resultStatusData
        case .failure(let err) :
            print(err.localizedDescription)
            break
        }
        return nil
    }
}
