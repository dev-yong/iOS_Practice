//
//  Payback.swift
//  MVVM_Example
//
//  Created by 이광용 on 2018. 2. 9..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation

struct Payback{
    var firstName: String
    var lastName: String
    let createdAt: Date
    var updatedAt: Date?
    var amount: Double!
    
    init(firstName: String, lastName: String, createdAt: Date, amount: Double) {
        self.firstName = firstName
        self.lastName = lastName
        self.createdAt = createdAt
        self.amount = amount
    }
}

extension Payback : Equatable {
    static func ==(lhs: Payback, rhs: Payback) -> Bool {
            return lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.createdAt == rhs.createdAt &&
            lhs.updatedAt == rhs.updatedAt &&
            lhs.amount == rhs.amount
    }
}
