//
//  TaCoExtension.swift
//  RxSwiftExample
//
//  Created by 이광용 on 2018. 2. 7..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    static var reuseIdentifier: String {
         return String(describing: self)
    }
}

extension UITableView  {
    func setUp(target: UITableViewDelegate & UITableViewDataSource, cell: UITableViewCell.Type) {
        self.delegate = target
        self.dataSource = target
        self.separatorStyle = .none
        //self.register(UINib(nibName: cell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionView {
    func setUp(target: UICollectionViewDelegate & UICollectionViewDataSource, cell: UICollectionViewCell.Type){
        self.delegate = target
        self.dataSource = target
        self.register(UINib(nibName: cell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    //Detect current cell
    func detectCurrentCellIndexPath() -> IndexPath? {
        var visibleRect = CGRect()
        visibleRect.origin = self.contentOffset
        visibleRect.size = self.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let visibleIndexPath: IndexPath = self.indexPathForItem(at: visiblePoint) {
            //print(visibleIndexPath)
            return visibleIndexPath
        }
        
        return nil
    }
    
    func currentCell() -> UICollectionViewCell {
        if let currentInex = self.detectCurrentCellIndexPath(), let cell = self.cellForItem(at: currentInex) {
            return cell
        }
        return UICollectionViewCell()
    }
    
}
