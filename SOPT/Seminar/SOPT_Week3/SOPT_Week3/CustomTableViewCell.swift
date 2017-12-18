//
//  CustomTableViewCell.swift
//  SOPT_Week3
//
//  Created by 이광용 on 2017. 10. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    //MARK: Property
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var pwLabel:UILabel!
    
    var info:CellInfo?{
        didSet{//viewDidLoad때 행해짐
            guard let imageName = info?.imageName else {return}
            self.customImageView.image = UIImage(named: imageName)
            self.nameLabel.text = info?.title
            self.pwLabel.text = info?.subTitle
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
