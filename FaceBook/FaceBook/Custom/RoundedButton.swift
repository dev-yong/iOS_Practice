//
//  RoundedButton.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 11. 29..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    //MARK:- Method
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func layoutSubviews() {
//        self.layer.borderColor = borderColor
//        self.layer.cornerRadius = cornerRadius
//        self.layer.borderWidth = borderWidth
//    }
    override func awakeFromNib() {
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
    
    
    //MARK:- Property
    @IBInspectable var borderColor: CGColor =  UIColor.lightGray.cgColor {
        didSet{
            self.layer.borderColor = borderColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
}
