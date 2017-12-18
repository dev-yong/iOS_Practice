//
//  TableViewCell.swift
//  ToDoList
//
//  Created by 이광용 on 2017. 10. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var info:model?{
        didSet{
            self.titleLabel.text = info?.title
            self.contentLabel.text = info?.content
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
