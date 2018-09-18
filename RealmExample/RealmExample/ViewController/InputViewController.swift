//
//  InputViewController.swift
//  RealmExample
//
//  Created by 이광용 on 2018. 1. 22..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveAction(_:)))
        rightBarButton.title = "Save"
       self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func saveAction(_ sender: UIBarButtonItem) {
        let contact: Contact = Contact()
        if let name = nameTextField.text, let phone = phoneTextField.text, !name.isEmpty, !phone.isEmpty {
            contact.name = name
            contact.phone = phone
            contact.birthDay = datePicker.date
            Contact.addToRealm(contact)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
