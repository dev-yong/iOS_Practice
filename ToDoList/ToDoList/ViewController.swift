//
//  ViewController.swift
//  ToDoList
//
//  Created by 이광용 on 2017. 10. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        todoList.append(model(title: "Test", content: "test"))
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(reLoadTableView(_:)), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Methods
    @objc func reLoadTableView(_ sender:UIRefreshControl){
        self.tableView.reloadData()
        sender.endRefreshing()
    }
}

//MARK:- Extension TableView
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath ) as! TableViewCell
        let item = todoList[indexPath.row]
        cell.info = item
        return cell
    }
    
    
}

