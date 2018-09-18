//
//  SignUpViewController.swift
//  SoptSeminar7
//
//  Created by ganghoon oh on 2017. 12. 2..
//  Copyright © 2017년 kanghoon. All rights reserved.
//

import UIKit
import SwiftyJSON

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.clipsToBounds = true
        self.profileImageView.image = #imageLiteral(resourceName: "profileImg")
    }
    
    @IBAction func touchUpSignUp(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let nickname = nicknameTextField.text else {return}
        guard let pw = pwTextField.text else {return}
        
        if(email.isNilOrEmpty() == false &&
            nickname.isNilOrEmpty() == false &&
            pw.isNilOrEmpty() == false){
            let parameter: [String: Any?] = ["email": email,
                                             "nickname": nickname,
                                             "pwd": pw,
                                             "image": profileImageView.image]
            SignService.getSignUpData(url: "signup", parameter: parameter)
            {
                (result) in
                let responseJSON = JSON(result)
                if responseJSON["status"] == "success"{
                    print("회원가입 성공")
                
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    
    @IBAction func touchUpProfileImage(_ sender: UITapGestureRecognizer) {
        showPicker()
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            self.profileImageView.image = editedImage
        }
        
        defer {
            self.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func showPicker()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}
