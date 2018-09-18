
//
//  CustomTableViewCell.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 17..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImg: RoundedImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var info:ContentInfo?{
        didSet{
            var image = #imageLiteral(resourceName: "ic_male_check")
            if let urlString = info?.profileImg{
                if let url = URL(string: urlString){
                    let data = try? Data(contentsOf: url)
                    if let imageData = data {
                        image = UIImage(data: imageData)!
                    }
                }
            }
            profileImg.image = image
            likeCountLabel.text = "\(info?.likeNum ?? 0)"
            likeLabel.text = (info?.p_isLike == 1 ? "♥︎":"♡")
            titleLabel.text = info?.title
            dateLabel.text = info?.date
            cornerAndShadow(view: backgroundImage)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func cornerAndShadow(view: UIView)
    {
        //view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.8
    }
    
}
