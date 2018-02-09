//
//  ViewController.swift
//  MVVM_Example
//
//  Created by 이광용 on 2018. 2. 8..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
}

class MasterViewController: UIViewController {
    let viewModel = ListViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refresh()
    }
    
    func refresh() {
        self.viewModel.refresh()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DetailViewController
        if segue.identifier == "createSegue" {
            nextVC.viewModel = DetailViewModel(delegate: nextVC)
        }
        else if segue.identifier == "editSegue" {
            nextVC.viewModel = DetailViewModel(delegate: nextVC, index: (tableView.indexPathForSelectedRow?.row)!)
        }
    }
}


extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
        let item = viewModel.items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.detailLabel.text = item.amount
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .none:
            break
        case .delete:
            self.viewModel.removePayback(index: indexPath.row)
            self.refresh()
        case .insert:
            break
        }
    }
}
