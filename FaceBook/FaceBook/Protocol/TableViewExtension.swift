//
//  TabelViewProtocol.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 12. 11..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation
import UIKit

extension UITableView
{
    func register<T: UITableViewCell> (cell: T.Type) 
    {
        //Using : self.tableView.register(cell: TableViewCell.self)
        let nib = UINib(nibName: cell.getIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cell.getIdentifier)
    }
    
    
    func dequeueReusableCell<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T
    {
        //Using : let cell = tableView.dequeueReusableCell(cell: TableViewCell.self, for: indexPath)
        guard let guardedCell = self.dequeueReusableCell(withIdentifier: cell.getIdentifier, for: indexPath) as? T else {fatalError("Could not dequeue cell with identifier: \(cell.getIdentifier)") }
        return guardedCell
    }
}


