//
//  menuCell.swift
//  Youtube
//
//  Created by 이광용 on 2017. 12. 6..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class menuCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    let defaultTintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
    override var isHighlighted: Bool
    {
        didSet{
            self.tintColor = isHighlighted ? UIColor.white : defaultTintColor
                //UIColor(red: 91, green: 14, blue: 13, alpha: 1)
        }
    }
    override var isSelected: Bool
    {
        didSet{
            self.tintColor = isSelected ? UIColor.white : defaultTintColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = defaultTintColor
    }
}
