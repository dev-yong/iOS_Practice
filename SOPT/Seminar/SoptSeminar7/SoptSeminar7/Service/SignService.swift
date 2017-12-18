//
//  SignService.swift
//  SoptSeminar7
//
//  Created by ganghoon oh on 2017. 12. 2..
//  Copyright © 2017년 kanghoon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SignService: APIServiece{
    
    static func getSignUpData(url: String, parameter: [String : Any?]?, completion: @escaping ([String:Any?])->())
    {
        Alamofire.upload(multipartFormData: {
            (multipartFormData) in
            
            guard let guardedParameter = parameter else {return}
            for (key, value) in guardedParameter {
                if(key != "image"){
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }
                else {
                    if let img = value as? UIImage {
                        self.addImageData(multipartFormData: multipartFormData, image: img, key: key, imageName: guardedParameter["nickname"] as! String)
                    }
//                    else {
//                        multipartFormData.append(Data() , withName: key)
//                    }
                }
            }
        },
                         usingThreshold: UInt64.init(),
                         to: self.getURL(url),
                         method: .post,
                         headers: nil, encodingCompletion: {
                            (encodingResult) in
                            switch encodingResult {
                            case .success(let uploadResponse, _, _) :
                                print("인코딩 성공")
                                uploadResponse.responseData(){
                                    (response) in
                                    print(response)
                                    guard let resultData = getStatusCodeAndResult(response: response) else {return}
                                    completion(resultData)
                                }
                                break
                            case .failure(let error) :
                                print("인코딩 실패")
                                print(error.localizedDescription)
                                break
                            }
        })
    }
    
    static func getLogInData(url: String, parameter: [String : Any]? ,completion: @escaping ([String:Any?])->())
    {
        let url = self.getURL(url)
        Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseData(){
            (response) in
            
            guard let resultData = getStatusCodeAndResult(response: response) else {return}
            completion(resultData)
        }
    }
    

    static func addImageData(multipartFormData: MultipartFormData, image: UIImage!, key: String!,  imageName: String!){
        var data = UIImagePNGRepresentation(image!)
        if data != nil {
            // PNG
            multipartFormData.append(data!, withName: key, fileName: imageName+".png", mimeType: "image/png")
        } else {
            // jpg
            data = UIImageJPEGRepresentation(image!, 1.0)
            multipartFormData.append((data?.base64EncodedData())!, withName: key, fileName: imageName+".jpeg", mimeType: "image/jpeg")
        }
    }

}

