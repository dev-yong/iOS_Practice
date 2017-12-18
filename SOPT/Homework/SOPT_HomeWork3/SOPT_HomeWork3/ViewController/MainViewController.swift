
//
//  MainViewController.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 12..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class MainViewController: UIViewController {
    //MARK:- Property
    //MARK: IBOutlet
    @IBOutlet weak var mailTextField: CustomTextField!
    @IBOutlet weak var pwTextField: CustomTextField!
    @IBOutlet weak var loginButton: CustomUIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet var textFieldCollection: [CustomTextField]!
    var performSegueBool: Bool = false
    //MARK: Variable
    
    //MARK:- Method
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initViewController()
    }
    //MARK: Function
    
    func initViewController(){
        
        mailTextField.text = ""
        pwTextField.text = ""
        loginButton.isEnabled = false
        mailTextField.addTarget(self, action: #selector(textFieldChanging(_:)), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(textFieldChanging(_:)), for: .editingChanged)
        
    }
    //MARK: IBAction
    @IBAction func unwindViewController(segue:UIStoryboardSegue){}
    
    @IBAction func logInButtonAction(_ sender: CustomUIButton) {
        guard let mail = mailTextField.text else{return}
        guard let pw = pwTextField.text else{return}
        let par = ["email": mail,
                   "password": pw]
        let networkManager = NetworkManager(self)
        networkManager.netWorkingResponseData(addURL: "appUser/login", method: .post, parameter: par, header: nil, code: "LogIn")
        
    }
}
//MARK:- Extension
//MARK: Networking
extension MainViewController: NetworkCallBack
{   
    func networkResultData(resultData: Data, code: String) {
        let result = JSON(resultData)
        print(result["profileImg"].stringValue)
        var profileImg: Data = UIImagePNGRepresentation(#imageLiteral(resourceName: "ic_male_check"))!
        
        if let imagePath = URL(string: result["profileImg"].stringValue){
            do{
                profileImg = try Data (contentsOf: imagePath)
            }
            catch(let err as NSError)
            {
                debugPrint(err.localizedDescription)
            }
        }
        //let image = UIImage(data: profileImg)
        let user = UserInfo(uid: result["uid"].intValue,
                                profileImg: profileImg,
                                name: result["name"].stringValue,
                                token: result["token"].stringValue)
        let userDefault = UserDefaults.standard
        userDefault.set(user.uid, forKey: "uid")
        userDefault.set(user.profileImg, forKey: "profileImg")
        userDefault.set(user.name, forKey: "name")
        userDefault.set(user.token, forKey: "token")
        self.performSegue(withIdentifier: "MainToContentSegue", sender: nil)
    }
    
    func networkFailed(msg: Any?) {
        let alert = UIAlertController(title: "경고", message: "아이디 또는 비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel, handler: {
            (UIAlertAction) in
            self.createButton.shake(10)
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        performSegueBool = false
    }
    
    
}
//MARK: UITextFieldDelegate
extension MainViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == mailTextField){
            shakeAndNextTextField(current: mailTextField, next: pwTextField)
        }
        else if(textField == pwTextField){
            shakeAndNextTextField(current: pwTextField, next: nil)
            if(loginButton.isEnabled){
                logInButtonAction(loginButton)
            }
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
                loginButton.isEnabled = false
                return
            }
        }
        loginButton.isEnabled = true
    }
}

extension MainViewController
{
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "MainToContentSegue"){
            return self.performSegueBool
        }
        return true
    }
}
