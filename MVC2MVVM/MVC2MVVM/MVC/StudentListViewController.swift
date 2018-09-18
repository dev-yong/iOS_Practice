//
//  ViewController.swift
//  MVC2MVVM
//
//  Created by 이광용 on 2018. 7. 27..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

class StudentListViewController: UIViewController {
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var students: [Student] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }

    @IBAction func addDataAction(_ sender:UIButton) {
        guard let name = self.textField1.text else {return}
        guard let address = self.textField2.text else {return}
        if !name.isEmpty && !address.isEmpty {
            self.students.append(Student(name: name,address: address))
            self.tableView.reloadData()
        }
    }
}

extension StudentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell") as! StudentTableViewCell
        cell.studentObject = self.students[indexPath.row]
        return cell
    }
}

