//
//  DetailViewModel.swift
//  MVVM_Example
//
//  Created by 이광용 on 2018. 2. 9..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation

public protocol DetailViewModelDelegate: class {
    func dismissAddView()
    func showInvalidName()
    func showInvalidAmount()
}

public class DetailViewModel {
    //MARK -: Property
    public var context: Context = Context.defualtContext
    public var title: String = "New Payback"
    public var name: String = ""
    public var amount: Double = 0.0
    public weak var delegate: DetailViewModelDelegate?
    private var index: Int = -1
    var isNew: Bool { return index == -1 }
    private var nameComponents: [String] {
        return name.components(separatedBy: " ").filter{ !$0.isEmpty }
    }
    
    public var info: String {
        return "\(self.nameComponents)\n\(self.amount)"
    }
    
    //MARK -: Initialize
    public init(delegate: DetailViewModelDelegate) {
        self.delegate = delegate
    }
    public convenience init(delegate: DetailViewModelDelegate, index: Int) {
        self.init(delegate: delegate)
        self.index = index
        title = "Edit Payback"
        let payback  = context.paybacks[index]
        self.name = "\(payback.firstName) \(payback.lastName)"
        self.amount = payback.amount
    }
    
    //MARK -: Method
    //MARK : Validate
    func validatedName() -> Bool {
        return self.nameComponents.count >= 2
    }
    
    func validateAmount() -> Bool {
        return self.amount.isNormal && self.amount > 0
    }
    
    func addPayback() {
        let payback = Payback(firstName: self.nameComponents[0], lastName: self.nameComponents[1], createdAt: Date(), amount: self.amount)
        self.context.addPayback(payback: payback)
    }
    
    func savePayback() {
        context.editPayback(index: index, firstName:self.nameComponents[0], lastName: self.nameComponents[1], amount: self.amount, updated: Date())
    }
    //MARK : Done
    public func done() {
        if !validatedName() { delegate?.showInvalidName() }
        else if !validateAmount() { delegate?.showInvalidAmount() }
        else {
            switch isNew {
            case true:
                addPayback()
            case false:
                savePayback()
            }
            delegate?.dismissAddView()
        }
    }
    
    
}

