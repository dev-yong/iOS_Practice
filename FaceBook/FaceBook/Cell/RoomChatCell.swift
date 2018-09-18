//
//  RoomChatCell.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 11. 26..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class RoomChatCell: UITableViewCell {
    @IBOutlet weak var profileImg: RoundedImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var message: Message?{
        didSet{
            guard let messageContent = message else {return}
            contentLabel.text = messageContent.text
            nameLabel.text = messageContent.friend?.name
            profileImg.image = UIImage(named: (messageContent.friend?.profileImg)!)
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.timeStyle = .short
            guard let date = messageContent.date else {return}
            
            let elapsedTimeInSeconds = NSDate().timeIntervalSince(date as Date)
            
            let secondInDays: TimeInterval = 60*60*24
            
            if elapsedTimeInSeconds >= 7 * secondInDays {
                formatter.dateFormat = "yyyy/MM/dd"
            }
                
            else if elapsedTimeInSeconds > secondInDays {
                formatter.dateFormat = "E"
            }
            
            dateLabel.text = formatter.string(from: date as Date)
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
