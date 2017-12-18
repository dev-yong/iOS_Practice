//
//  ChatViewController.swift
//  SOPT_Week6
//
//  Created by 이광용 on 2017. 11. 25..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MyChatTableViewCell", bundle: nil), forCellReuseIdentifier: "MyChatTableViewCell")
        self.tableView.register(UINib(nibName: "YourChatTableViewCell", bundle: nil), forCellReuseIdentifier: "YourChatTableViewCell")
        
        self.setKeyboardSetting()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourChatTableViewCell", for: indexPath)
            return cell
        }
    }
}

extension ChatViewController{
    func setKeyboardSetting()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.kyeboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.kyeboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    @objc func kyeboardWillShow(_ notification: Notification)
    {
        if let keyboadSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            adjustKeyboardDismissTapGesture(isKeyboardVisible: true)
            self.bottomConstraint.constant = keyboadSize.height
            
            if let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval{
                UIView.animate(withDuration: animationDuration, animations: { self.view.layoutIfNeeded()})
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func kyeboardWillHide(_ notification: Notification)
    {
        if let keyboadSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            self.bottomConstraint.constant = 0
            
            if let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval{
                UIView.animate(withDuration: animationDuration, animations: { self.view.layoutIfNeeded()})
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func adjustKeyboardDismissTapGesture(isKeyboardVisible: Bool){
        if isKeyboardVisible{
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            }
        }
        else{
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
}

