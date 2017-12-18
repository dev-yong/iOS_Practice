//
//  ExtensionControl.swift
//  SoptSeminar7
//
//  Created by ganghoon oh on 2017. 12. 2..
//  Copyright © 2017년 kanghoon. All rights reserved.
//

import Foundation

extension NSObject{
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    func isNilOrEmpty()->Bool{
        if(self.trim().isEmpty){return true}
        else{return false}
    }
}        
