//
//  ViewController.swift
//  Messenger
//
//  Created by 이광용 on 2017. 12. 4..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageLogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLogTableView.separatorStyle = .none
        messageLogTableView.dataSource = self
        messageLogTableView.delegate = self
        self.messageLogTableView.register(UINib(nibName: "MyBubbleCell", bundle: nil), forCellReuseIdentifier: "MyBubbleCell")
    }
}

extension ViewController: UITableViewDelegate
{
    //Transparent Cell Background
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyBubbleCell", for: indexPath)
        return cell
    }
}
