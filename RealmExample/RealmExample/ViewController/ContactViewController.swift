//
//  ViewController.swift
//  RealmExample
//
//  Created by 이광용 on 2018. 1. 15..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ContactViewController: UIViewController {
    var contactArray = Contact.realm.objects(Contact.self)
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    private var token: NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        
        token = contactArray.observe({ (change) in
            self.tableView.reloadData()
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tableView.reloadData()
        //print(NSHomeDirectory())
    }
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        let nextVC: InputViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: InputViewController.reuseIdentifier) as! InputViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func removeAction(_ sender: UIBarButtonItem) {
        Contact.removeFromAllRealm()
        //self.tableView.reloadData()
    }
    
}

extension ContactViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactCell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier, for: indexPath) as! ContactCell
        cell.info = contactArray[indexPath.row]
        return cell
    }
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (deleteAction, indexPath) in
            Contact.removeFromRealm(self.contactArray[indexPath.row])
        }
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}

extension ContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let text = textField.text {
                if text.count > 0 {
                    self.contactArray = Contact.realm.objects(Contact.self).filter("name contains '\(text)'")
                }
                else {
                    self.contactArray = Contact.realm.objects(Contact.self)
                    
                }
                //self.tableView.reloadData()
            }
        }
        return true
    }
}

class ContactCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    var info: Contact! {
        didSet{
            self.titleLabel.text = info.name
            self.detailLabel.text = info.phoneNumeber
        }
    }
}
