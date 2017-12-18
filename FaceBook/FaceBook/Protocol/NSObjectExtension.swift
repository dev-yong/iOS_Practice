//
//  ReusableNSObject.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 12. 11..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation

extension NSObject
{
    static var getIdentifier: String{
        return String(describing: self)
    }
    //Using: nsObject.getIdentifier
}
