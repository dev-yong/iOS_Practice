//
//  Gettable.swift
//  SoptSeminar7
//
//  Created by 이광용 on 2017. 12. 11..
//  Copyright © 2017년 kanghoon. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Failure(Error)
}

protocol Gettable {
    associatedtype T //Associated type = type alias + generics
    func get(completionHandler: (Result<T>) -> Void)
}
