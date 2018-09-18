//
//  Context.swift
//  MVVM_Example
//
//  Created by 이광용 on 2018. 2. 9..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation

public class Context {
    static var defualtContext = Context()
    
    var paybacks = [Payback]()
    
    func addPayback(payback: Payback) {
        self.paybacks.insert(payback, at: 0)
    }
    
    func editPayback(index: Int, firstName: String, lastName: String, amount: Double, updated: Date) {
        paybacks[index].firstName = firstName
        paybacks[index].lastName = lastName
        paybacks[index].amount = amount
        paybacks[index].updatedAt = updated
    }
    
    func removePayback(index: Int) {
        self.paybacks.remove(at: index)
    }
}
