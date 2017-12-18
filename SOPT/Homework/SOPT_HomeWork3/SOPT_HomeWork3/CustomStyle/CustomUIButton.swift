//
//  CustomUIButton.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 12..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

@IBDesignable
class CustomUIButton: UIButton {
    //MARK:- Property
    @IBInspectable var defaultBackgroundColor:UIColor! = nil{
        didSet{
            initButton(customBackgroundColor: defaultBackgroundColor)
        }
    }
    
    override var isEnabled: Bool{
        didSet{
            if(isEnabled == true){
                initButton(customBackgroundColor: defaultBackgroundColor)
            }
            else {
                initButton(customBackgroundColor: UIColor.gray)
            }
        }
    }
    
    override var isHighlighted: Bool{
        didSet{
            if(isHighlighted){
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            }
            else{
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
            }
        }
    }
    
    //MARK:- Method
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        initButton(customBackgroundColor: nil)
    }
    //MARK: Function
    func initButton(customBackgroundColor:UIColor!)
    {
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.darkGray, for: .disabled)
        self.customLayer()
        self.backgroundColor = customBackgroundColor?.withAlphaComponent(0.5)
        self.layer.borderColor = self.backgroundColor?.cgColor
    }
    
    
}
