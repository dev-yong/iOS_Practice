//
//  NSObject+Week3.swift
//  SOPT_Week3
//
//  Created by 이광용 on 2017. 10. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation

extension NSObject{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}
