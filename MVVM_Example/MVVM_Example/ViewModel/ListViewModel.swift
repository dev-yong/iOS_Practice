//
//  ListViewModel.swift
//  MVVM_Example
//
//  Created by 이광용 on 2018. 2. 9..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation

public struct Item {
    public let title: String
    public let subtitle: String
    public let amount: String
}

public class ListViewModel {
    public var context = Context.defualtContext
    public var items = [Item]()
    
    public func refresh() {
        items = context.paybacks.map{ self.itemForPayback(payback: $0) }
        print(items)
    }
    
    func itemForPayback(payback: Payback) -> Item {
    
        let fullName = "\(payback.firstName) \(payback.lastName)"
        let subtitle = DateFormatter.localizedString(from: payback.createdAt, dateStyle: .long, timeStyle: .none)
        let amount = "\(Int(round(payback.amount)))"
        return Item(title: fullName, subtitle: subtitle, amount: amount)
    }
    
    func removePayback(index: Int) {
        context.removePayback(index: index)
    }
}
