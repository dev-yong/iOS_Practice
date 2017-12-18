//
//  TitleTextField.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 15..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

@IBDesignable
class TitleTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addBorderBottom(height: 1.0, color: UIColor.lightGray)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addBorderBottom(height: 1.0, color: UIColor.lightGray)
    }
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.bounds.height-height, width: self.bounds.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
