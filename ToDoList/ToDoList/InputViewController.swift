//
//  InputViewController.swift
//  ToDoList
//
//  Created by 이광용 on 2017. 10. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UITextFieldDelegate {
    //MARK:- Property
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextField!
    var alert:UIAlertController!

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == titleField){
            self.contentField.becomeFirstResponder()
        }
        else if(textField == contentField){
            self.contentField.resignFirstResponder()
        }
        return true
    }

    //MARK:- IBAction
    @IBAction func okBtnAction(_ sender: UIButton) {
        guard let titleText: String = self.titleField.text else {return }
        if titleText.NilOrEmpty() == true{
            alert = UIAlertController(title: "경고", message: "Please input Title", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인", style: .default, handler: {(UIAlertAction)
                in self.titleField.becomeFirstResponder()
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard let contentText: String = self.contentField.text else {return }
        if contentText.NilOrEmpty() == true{
            alert = UIAlertController(title: "경고", message: "Please input Content", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인", style: .default, handler: {(UIAlertAction)
                in self.contentField.becomeFirstResponder()
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        todoList.append(model(title: titleText, content: contentText))
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancleTouchUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    func NilOrEmpty()->Bool{
        if(self.trim().isEmpty){return true}
        else{return false}
    }
}
