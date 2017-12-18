//
//  ViewController.swift
//  SOPT_Week3
//
//  Created by 이광용 on 2017. 10. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //MARK: Property
    @IBOutlet weak var idField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.idField){
           self.passwordField.becomeFirstResponder()
        }
        else if textField == self.passwordField{
            //network logic
            self.passwordField.resignFirstResponder()
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //idField.delegate = self
        //passwordField.delegate = self
        //StoryBoard에서는 textfield를 ViewController에 드래그해주면된다.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

