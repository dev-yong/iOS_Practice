//
//  ViewController.swift
//  SOPT_HomeWork2
//
//  Created by 이광용 on 2017. 10. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK:- Properties
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var checkPerformSegue:Bool = false
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        idTextField.text = nil
        pwTextField.text = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "MainToConfirm"){
            return checkPerformSegue
        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "MainToConfirm"){
            let confirmVC = segue.destination as! ConfirmViewController
            confirmVC.people = sender as? People
        }
    }
    //MARK:- IBAction
    @IBAction func unwindViewController(segue:UIStoryboardSegue){}
    @IBAction func logInBtnTouchUp(_ sender: UIButton) {
        var alert : UIAlertController!
        guard let idText = idTextField.text else {return}
        guard let pwText = pwTextField.text else {return}
        if(idText.NilOrEmpty() || pwText.NilOrEmpty()){
            alert = UIAlertController(title: "경고", message: "아이디 또는 패스워드를 입력해주세요.", preferredStyle: .actionSheet)
            let alertAction = UIAlertAction(title: "확인", style: .default, handler:{(UIAlertAction) in self.idTextField.becomeFirstResponder()})
            alert.addAction(alertAction)
            checkPerformSegue = false
            self.present(alert, animated: true, completion: nil)
        }
        else{
            checkPerformSegue = true
            self.performSegue(withIdentifier: "MainToConfirm", sender: People(id: idText, pw: pwText, name: "이광용", age: "24", gender: #imageLiteral(resourceName: "ic_male_check.png")))
        }
    }
}

//MARK:- Extension
extension ViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == idTextField){
            pwTextField.becomeFirstResponder()
        }
        else if(textField == pwTextField){
            pwTextField.resignFirstResponder()
            logInBtnTouchUp(loginBtn)
        }
        return true
    }
}

public extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    func NilOrEmpty()->Bool{
        if(self.trim().isEmpty){return true}
        else{return false}
    }
}
