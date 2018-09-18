//
//  NSObject+HomerWork2.swift
//  SOPT_HomeWork2
//
//  Created by 이광용 on 2017. 10. 30..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation

extension NSObject{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}
