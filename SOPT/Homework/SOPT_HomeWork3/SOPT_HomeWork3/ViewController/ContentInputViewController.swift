//
//  ContentInputViewController.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 15..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
import IQKeyboardManagerSwift

class ContentInputViewController: UIViewController {
    //MARK:- Property
    @IBOutlet weak var titleTextField: TitleTextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var uploadButton: UIBarButtonItem!
    
    //MARK:- Method
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        IQKeyboardManager.sharedManager().enable = false
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        NotificationCenter.default.addObserver(self,
          selector: #selector(updateTextView(notification:)),
          name: NSNotification.Name.UIKeyboardWillChangeFrame,
          object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initViewController()
    }
    
    //MARK: Function
    func initViewController()
    {
        titleTextField.text = ""
        contentTextView.text = ""
        uploadButton.isEnabled = false
        titleTextField.addTarget(self, action: #selector(textFieldChanging(_:)), for: .editingChanged)
    }
    @IBAction func uploadButtonTouchUp(_ sender: UIBarButtonItem) {
        let network = NetworkManager(self)
        let param: [String:Any] = ["uid": UserDefaults.standard.integer(forKey: "uid"),
                     "title": titleTextField.text!,
                     "content": contentTextView.text!]
        
        let header: HTTPHeaders = ["token": UserDefaults.standard.string(forKey: "token")!]
        network.netWorkingResponseData(addURL: "appContent", method: .post, parameter: param, header: header, code: "Upload")
        
    }
    
}

//MARK:- Extension
//MAKR: TextField, TextView
extension ContentInputViewController: UITextFieldDelegate, UITextViewDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.contentTextView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == titleTextField){
            if(titleTextField.text?.NilOrEmpty() == true){titleTextField.shake(10)}
            else{
                    contentTextView.becomeFirstResponder()
            }
        }
        return true
    }
    
    @objc func textFieldChanging(_ textField:UITextField){
        enableUploadButton()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == contentTextView {
            enableUploadButton()
        }
    }
    
    func enableUploadButton()
    {
        if(titleTextField.text?.NilOrEmpty() == true ||
            contentTextView.text?.NilOrEmpty() == true){
            uploadButton.isEnabled = false
            return
        }
        uploadButton.isEnabled = true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(textView.text.characters.count)
        return true
    }
    
    @objc func updateTextView(notification: Notification)
    {
        let userInfo = notification.userInfo!
        let keyboardEndFrameScreenCoordinates = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = self.view.convert(keyboardEndFrameScreenCoordinates, to: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            contentTextView.contentInset = UIEdgeInsets.zero
        }
        else {
            contentTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
            contentTextView.scrollIndicatorInsets = contentTextView.contentInset
        }
        
        contentTextView.scrollRangeToVisible(contentTextView.selectedRange)
    }
    
}

//MARK: Network
extension ContentInputViewController: NetworkCallBack
{
    func networkResultData(resultData: Data, code: String) {
        debugPrint(resultData)
        self.navigationController?.popViewController(animated: true)
    }
    
    func networkFailed(msg: Any?) {
        debugPrint(msg)
        self.view.makeToast("컨텐츠 업로드가 실패하였습니다.")
    }
    
    
}
