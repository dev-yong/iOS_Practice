//
//  NetworkManager.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 14..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager{
    internal let baseURL = "http://52.79.136.159:3000/"
    var delegate: NetworkCallBack
    
    init(_ delegate: NetworkCallBack) {
        self.delegate = delegate
    }
    func uploadDataResponseJSON(addURL: String, method: HTTPMethod, parameter: [String:Any], imgParameter: UIImage?, header: HTTPHeaders?)
    {
        let img: UIImage
        if imgParameter != nil {img = imgParameter!}
        else {img = #imageLiteral(resourceName: "ic_male_check")}
    
        Alamofire.upload(multipartFormData: { multipartFormData in
            self.addImageData(multipartFormData: multipartFormData, image: img, imageName: parameter["name"] as! String)
            for (key, value) in parameter{
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            },
            usingThreshold: UInt64.init(),
            to: baseURL + addURL,
            method: method,
            headers: header,
            encodingCompletion: { encodingResult in
                switch encodingResult{
                case .success(let uploadResponse, _, _):
                    print("업로드 성공")
                    uploadResponse.responseJSON(){ response in
                        if let status = response.response?.statusCode{
                            print(response)
                            debugPrint(response.data)
                            self.statusCheck(status: status, result: response.data, code: "")
                        }
                    }
                case .failure(let encodingError):
                    print("업로드 실패")
                    print(encodingError)
                }
        })
    }
    func netWorkingResponseData(addURL: String, method: HTTPMethod, parameter: [String:Any]?, header: HTTPHeaders?, code: String) {
        Alamofire.request(baseURL + addURL, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseData(){
            response in
            switch response.result{
            case .success :
                print("네트워크 접속 성공")
                if let status = response.response?.statusCode{
                    print(response)
                    self.statusCheck(status: status, result: response.data, code: code)
                }
                break
            case .failure(let err) :
                print("네트워크 접속 실패")
                print(err.localizedDescription)
                break
            }
        }
    }
    
    func netWorkingResponseJSON(addURL: String, method: HTTPMethod, parameter: [String:Any]?, header: HTTPHeaders?, code: String) {
        Alamofire.request(baseURL + addURL, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON(){
            response in
            switch response.result{
            case .success :
                print("네트워크 접속 성공")
                if let status = response.response?.statusCode{
                    print(response)
                    self.statusCheck(status: status, result: response.data, code: code)
                }
                break
            case .failure(let err) :
                print("네트워크 접속 실패")
                print(err.localizedDescription)
                break
            }
        }
    }
    

    
    private func addImageData(multipartFormData: MultipartFormData, image: UIImage!, imageName: String!){
        var data = UIImagePNGRepresentation(image!)
        if data != nil {
            // PNG
            multipartFormData.append(data!, withName: "profileImg",fileName: imageName+".png", mimeType: "image/png")
        } else {
            // jpg
            data = UIImageJPEGRepresentation(image!, 1.0)
            multipartFormData.append((data?.base64EncodedData())!, withName: "profileImg", fileName: imageName+".jpeg", mimeType: "image/jpeg")
        }
    }
    
    func statusCheck(status: Int!, result: Data?, code:String)
    {
        print(status)
        debugPrint(result)
        switch status{
        case 200:
            print("success")
            if(result != nil) {self.delegate.networkResultData(resultData: result!, code: code)}
            else {self.delegate.networkFailed(msg: nil)}
        default:
            self.delegate.networkFailed(msg: result)
        }
    }
}


