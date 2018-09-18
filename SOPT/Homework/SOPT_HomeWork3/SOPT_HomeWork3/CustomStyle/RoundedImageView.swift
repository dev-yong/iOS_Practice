//
//  RoundedImageView.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 13..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable var divisor: CGFloat = 2.0 {
        didSet{
            self.layer.cornerRadius = self.frame.width/divisor
        }
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.white {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    override func layoutSubviews() {
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = self.frame.width/divisor
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
}
