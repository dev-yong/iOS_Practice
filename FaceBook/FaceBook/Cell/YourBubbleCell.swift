//
//  YourBubbleCell.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 11. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class YourBubbleCell: UITableViewCell {
    @IBOutlet weak var friendProfileImg: RoundedImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
