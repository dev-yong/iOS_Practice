//
//  DetailViewController.swift
//  MVVM_Example
//
//  Created by 이광용 on 2018. 2. 9..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.numberOfLines = 0
        
        self.navigationItem.title = self.viewModel.title
        self.nameField.text = self.viewModel.name
        self.amountField.text = "\(self.viewModel.amount)"
        self.nameField.becomeFirstResponder()
        
        self.nameField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        self.amountField.addTarget(self, action: #selector(ammountChanged), for: .editingChanged)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
    }
    
    @objc func doneAction() {
        viewModel.done()
    }
    
    @objc func nameChanged() {
        viewModel.name = nameField.text!
        resultLabel.text = viewModel.info
    }
    
    @objc func ammountChanged() {
        viewModel.amount = NumberFormatter().number(from: amountField.text!)?.doubleValue ?? 0.0
        resultLabel.text = viewModel.info
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func dismissAddView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showInvalidName() {
        print("Invalid Name")
        nameField.becomeFirstResponder()
    }
    
    func showInvalidAmount() {
        print("Invalid Amount")
        amountField.becomeFirstResponder()
    }
}
