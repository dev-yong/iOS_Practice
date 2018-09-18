//
//  StudentTableViewCell.swift
//  MVC2MVVM
//
//  Created by 이광용 on 2018. 7. 27..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    var studentObject: Student? {
        didSet {
            self.textLabel?.text = studentObject?.name
            self.detailTextLabel?.text = studentObject?.address
        }
    }

}
