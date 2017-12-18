//
//  RegisterViewController.swift
//  SOPT_HomeWork2
//
//  Created by 이광용 on 2017. 10. 30..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK:- Properties
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet var toggleBtnCollection: [UIButton]!
    @IBOutlet weak var maleBtn: UIButton!
    
    var checkPerformSegue:Bool = false
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        maleBtn.isSelected = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "RegisterToConfirm"){
            let destination = segue.destination as! ConfirmViewController
            destination.people = sender as? People
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "RegisterToConfirm"){
            return checkPerformSegue
        }
        return true
    }
    //MAKR:- IBAction
    @IBAction func registerBtnTouchUp(_ sender: Any) {
        nextConfrimViewController()
    }
    
    @IBAction func toggleBtnTouchUp(_ sender:UIButton){
        for button in toggleBtnCollection
        {
            if(button == sender){
                button.isSelected = true
            }
            else{
                button.isSelected = false
            }
        }
    }
    
    @objc func nextConfrimViewController(){
        guard let idText = idTextField.text else {return}
        guard let pwText = pwTextField.text else {return}
        guard let nameText = nameTextField.text else {return}
        guard let ageText = ageTextField.text else {return}
        if(idText.NilOrEmpty() || pwText.NilOrEmpty() || nameText.NilOrEmpty() || ageText.NilOrEmpty()){
            checkPerformSegue = false
            let alert = UIAlertController(title: "경고", message: "모든 항목을 채워주세요.", preferredStyle: .actionSheet)
            let alertAction = UIAlertAction(title: "확인", style: .default, handler: {(UIAlertAction) in self.idTextField.becomeFirstResponder()})
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            checkPerformSegue = true
            var genderImage: UIImage = #imageLiteral(resourceName: "ic_male_check")
            for selectedBtn in toggleBtnCollection
            {
                if(selectedBtn.isSelected == true)
                {
                    genderImage = selectedBtn.currentImage!
                }
            }
            self.performSegue(withIdentifier: "RegisterToConfirm", sender:
            People(id: idText, pw: pwText, name: nameText, age: ageText, gender: genderImage))
        }
    }
}

//Extension
extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == idTextField){pwTextField.becomeFirstResponder()}
        else if(textField == pwTextField){nameTextField.becomeFirstResponder()}
        else if(textField == nameTextField){ageTextField.becomeFirstResponder()}
        else if(textField == ageTextField){nextConfrimViewController()}
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == ageTextField){
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

