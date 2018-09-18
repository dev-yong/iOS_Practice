//
//  ViewController.swift
//  ARC
//
//  Created by 이광용 on 2018. 5. 11..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    //var tenant: Person?
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

protocol ViewControllerDelegate: class {
    
}


class ViewController: UIViewController {
    var john: Person?
    var unit4A: Apartment?
    var delegate: ViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        john = Person(name: "John Appleseed")
        unit4A = Apartment(unit: "4A")
        
        john!.apartment = unit4A
        unit4A!.tenant = john
        
        john = nil
        unit4A = nil
        
        
    }
    
    lazy var someClosure: () -> String = {
        [unowned self, weak delegate = self.delegate!] in
        // closure body goes here
        return ""
    }
}

