//
//  APIRouter.swift
//  UPAYm
//
//  Created by 이광용 on 2018. 9. 17..
//  Copyright © 2018년 UMS. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class APIRouter {
    static let shared = APIRouter()
    public var baseURL: URLType = .dev
    
    func request<T: Mappable>(_ service: APIService, completion: @escaping (_ code: Int?, _ response: T?) -> Void ) {
        let url = "\(APIRouter.shared.baseURL.description)" + service.path
        
        Alamofire.request(url,
                          method: service.method,
                          parameters: service.parameters,
                          headers: service.header)
            .responseObject { (response: DataResponse<T>) in
                let result = response.result.value
                completion(response.response?.statusCode, result)
        }
    }
    
    func requestCollection<T: Mappable>(_ service: APIService, completion: @escaping (_ code: Int?, _ response: [T]?) -> Void) {
        let url = "\(APIRouter.shared.baseURL.description)" + service.path
        
        Alamofire.request(url,
                          method: service.method,
                          parameters: service.parameters,
                          headers: service.header)
            .responseArray { (response: DataResponse<[T]>) in
                let results = response.result.value
                completion(response.response?.statusCode, results)
        }
    }
   
    func upload<T: Mappable>(_ service: APIService, imageKey: String?, images: [UIImage?], completion: @escaping (_ code: Int?, _ response: T?) -> Void ) {
        let url = "\(APIRouter.shared.baseURL.description)" + service.path
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (index, item) in images.enumerated() {
                if let item = item, let imageKey = imageKey {
                    multipartFormData.append(item, key: imageKey, fileName: "\(index)")
                }
            }
            if let parameters = service.parameters as? [String: String] {
                multipartFormData.append(parameters)
            }
        },
                         usingThreshold: UInt64.init(),
                         to: url,
                         method: service.method,
                         headers: service.header) { (encodingResult) in
                            switch encodingResult {
                            case .success(let upload, _, _) :
                                print("Encoding Complete")
                                upload.uploadProgress { progress in
                                    let value = Int(progress.fractionCompleted * 100)
                                    print(value)
                                }
                                upload.responseObject{ (response: DataResponse<T>) in
                                    
                                    let result = response.result.value
                                    completion(response.response?.statusCode, result)
                                }
                            case .failure(let error) :
                                
                                print(error.localizedDescription)
                            }
        }
    }
}

extension MultipartFormData {
    func append(_ parameters: [String: String]) {
        for (key, value) in parameters {
            guard let data = value.data(using: .utf8) else {return}
            self.append(data, withName: key)
        }
    }
    
    func append(_ image: UIImage, key: String, fileName: String) {
        guard let image = image.compress(toWidth: 512) else {return}
        print(image.description)
        guard let data = UIImagePNGRepresentation(image) else {return}
        self.append(data, withName: key, fileName: fileName+".png", mimeType: "image/png")
    }
}

extension UIImage {
    func compress(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func compress(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
