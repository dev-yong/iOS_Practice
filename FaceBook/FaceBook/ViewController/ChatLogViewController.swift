//
//  ChatLogViewController.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 11. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import CoreData
class ChatLogViewController: UIViewController {
    //MARK:- Property
    //MARK: Data
    var friend: Friend? {
        didSet{
            self.navigationItem.title = friend?.name
            messages = friend?.message?.allObjects as? [Message]
            messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedAscending})
        }
    }
    var messages: [Message]?
    //MARK: IBOutlet
    @IBOutlet weak var chatLogTableView: UITableView!
    @IBOutlet weak var inputViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTextView: UITextView!
    
    //MARK: Dismiss Keyboard
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    //MARK:- Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setOverlayKeyboardSetting()
        
        //Setting TableView
        self.chatLogTableView.dataSource = self
        self.chatLogTableView.delegate = self
        self.chatLogTableView.separatorStyle = .none
        self.chatLogTableView.allowsSelection = false
        
        //Register TableView Cell
        self.chatLogTableView.register(cell: MyBubbleCell.self)
        self.chatLogTableView.register(cell: YourBubbleCell.self)

    }
}

//MARK:- Extension

//MARK: TableView Delegate
extension ChatLogViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}

//MARK: TableView DataSource
extension ChatLogViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = messages?.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let message = messages?[indexPath.row] else {return UITableViewCell()}
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeStyle = .short
        guard let date = messages?[indexPath.row].date else {return UITableViewCell()}
        let dateString = formatter.string(from: date as Date)
        
        if message.isSender {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MyBubbleCell", for: indexPath) as! MyBubbleCell
            let cell = tableView.dequeueReusableCell(cell: MyBubbleCell.self, for: indexPath)
            cell.contentLabel.text = message.text
            cell.timeLabel.text = dateString
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourBubbleCell", for: indexPath) as! YourBubbleCell
            cell.friendProfileImg.image = UIImage(named: (friend?.profileImg)!)
            cell.friendNameLabel.text = friend?.name
            cell.contentLabel.text = message.text
            cell.timeLabel.text = dateString
            return cell
        }
    }
}

//MARK: Dismiss Keyboard
extension ChatLogViewController
{
    func setOverlayKeyboardSetting(){
        //Add Observer Keyboard Will Show & Hide
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func adjustKeyboardDismissTapGesture(isKeyboardVisible: Bool){
        if isKeyboardVisible{
            if keyboardDismissGesture == nil{
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        }else{
            if keyboardDismissGesture != nil{
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        adjustKeyboardDismissTapGesture(isKeyboardVisible: true)
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.inputViewBottomConstraint.constant = keyboardSize.height
            
            if let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
                UIView.animate(withDuration: animationDuration, animations: {
                    self.view.layoutIfNeeded()
                }){
                    (completed) in
                    guard let guardedMessages = self.messages else {return }
                    let indexPath = IndexPath(row: guardedMessages.count - 1, section: 0)
                    self.chatLogTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        adjustKeyboardDismissTapGesture(isKeyboardVisible: false)
        self.inputViewBottomConstraint.constant = 0
        if let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
            UIView.animate(withDuration: animationDuration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    
}
