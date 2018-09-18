//
//  TargetType.swift
//  Network
//
//  Created by 이광용 on 2018. 7. 21..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation
import Alamofire

public protocol TargetType {
    
    /// The target's base `URL`.
    var baseURL: URL { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// Provides stub data for use in testing.
    var sampleData: Data { get }
    
    /// The type of HTTP task to be performed.
    var task: Task { get }
    
    /// The type of validation to perform on the request. Default is `.none`.
    var validationType: ValidationType { get }
    
    /// The headers to be used in the request.
    var headers: [String: String]? { get }
}

public extension TargetType {
    
    /// The type of validation to perform on the request. Default is `.none`.
    var validationType: ValidationType {
        return .none
    }
}
