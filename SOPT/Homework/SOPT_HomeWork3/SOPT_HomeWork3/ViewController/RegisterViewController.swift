//
//  RegisterViewController.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 14..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterViewController: UIViewController {
    //MARK:- Property
    @IBOutlet weak var registerBarButton: UIBarButtonItem!
    @IBOutlet weak var userImageView: RoundedImageView!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var mailTextField: CustomTextField!
    @IBOutlet weak var pwTextField: CustomTextField!
    @IBOutlet var textFieldCollection: [CustomTextField]!
    //MARK: Variable
    var delegate:RegisterViewController! = nil
    
    //MARK:- Method
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initViewController()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Function
    func initViewController(){
        userImageView.image = #imageLiteral(resourceName: "ic_male_check")
        mailTextField.text = ""
        pwTextField.text = ""
        nameTextField.text = ""
        registerBarButton.isEnabled = false
        mailTextField.addTarget(self, action: #selector(textFieldChanging(_:)), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(textFieldChanging(_:)), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(textFieldChanging(_:)), for: .editingChanged)
    }
    //MARK: IBAction
    @IBAction func imageTapGesture(_ sender: UITapGestureRecognizer) {
        showImagePicker()
    }
    @IBAction func registerButtonAction(_ sender: Any) {
        guard let email = mailTextField.text else {return}
        guard let password = pwTextField.text else {return}
        guard let name = nameTextField.text else {return}
        guard let profile = userImageView.image else {return}
        
        let parameter: [String: Any] = ["email" : email,
                                        "password" : password,
                                        "name" : name]
        let networkManager = NetworkManager(self)
        networkManager.uploadDataResponseJSON(addURL: "appUser/signUp", method: .post, parameter: parameter, imgParameter: profile, header: nil)
    }
}

extension RegisterViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == nameTextField){
            shakeAndNextTextField(current: nameTextField, next: mailTextField)
        }
        else if(textField == mailTextField){
            shakeAndNextTextField(current: mailTextField, next: pwTextField)
        }
        else if(textField == pwTextField){
            shakeAndNextTextField(current: pwTextField, next: nil)
            registerButtonAction(registerBarButton)
        }
        return true
    }
    
    func shakeAndNextTextField(current:UITextField, next:UITextField!){
        if(current.text?.NilOrEmpty() == true){current.shake(10)}
        else{
            if next != nil{
                next.becomeFirstResponder()
            }
            else{
                current.resignFirstResponder()
            }
        }
    }
    
    @objc func textFieldChanging(_ textField:UITextField){
        for item in textFieldCollection{
            if(item.text?.NilOrEmpty() == true){
                registerBarButton.isEnabled = false
                return
            }
        }
        registerBarButton.isEnabled = true
    }
}

//MARK:- Extension
extension RegisterViewController: NetworkCallBack
{
    func networkResultData(resultData: Data, code: String) {
        print("가입성공")
        self.performSegue(withIdentifier: "unwindToLogIn", sender: true)
    }
    
    func networkFailed(msg: Any?) {
        let alert = UIAlertController(title: "경고", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        if let message = msg {
            let msgJObj = JSON(message)
            let content:String = msgJObj["msg"].stringValue
            if content == "username duplication" {alert.message = "동일한 이름이 존재합니다."}
            else if content == "already exist email" {alert.message = "동일한 이메일이 존재합니다."}
        }
        self.present(alert, animated: true, completion: nil)
    }
}
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func showImagePicker()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.userImageView.image = editedImage
            self.userImageView.contentMode = .scaleAspectFit
        }
        
        defer{
            self.dismiss(animated: true, completion: nil)
        }
    }
}

