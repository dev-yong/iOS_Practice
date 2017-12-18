//
//  LoginViewController.swift
//  SoptSeminar7
//
//  Created by ganghoon oh on 2017. 12. 2..
//  Copyright © 2017년 kanghoon. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInButtonTouchUP(_ sender: UIButton) {
        getLoginData()
    }
    
    func getLoginData()
    {
        guard let id = idTextField.text else {return}
        guard let pw = pwTextField.text else {return}
        let parameter = ["email" : id , "pwd" : pw]
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC: UITabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {return}
        
        SignService.getLogInData(url: "signin", parameter: parameter){
            (result) in
            
            guard let code = result["code"] as? Int,
                let data = result["data"] as? Data
                else {return}
            
            switch code
            {
            case 201..<400 :
                let responseJSON = JSON(data)
                
                let data = responseJSON["data"]
                print(data["email"])
                print(data["nickname"])
                print(data["profile"])
                self.navigationController?.present(nextVC, animated: true, completion: nil)
                break
            case 401:
                break
            case 500:
                break
            default:
                break
            }
        }
    }
    
    @IBAction func signUPButtonTouchUP(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC: SignUpViewController = storyBoard.instantiateViewController(withIdentifier: SignUpViewController.reuseIdentifier) as? SignUpViewController else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
