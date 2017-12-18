//
//  ToggleButton.swift
//  SOPT_HomeWor1
//
//  Created by 이광용 on 2017. 9. 23..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    var isOn = false;
    var alternateButton:Array<ToggleButton>?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initButton()
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        initButton()
    }
    
    func initButton()
    {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = UIColor.gray
        self.setTitleColor(UIColor.white, for: .normal)
        self.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @IBAction func buttonPressed(sender:UIButton){
        unselectedAlternateButton()
    }
    
    func unselectedAlternateButton(){
        if alternateButton != nil{
            activateButton(bool: true)
            for tmpBtn:ToggleButton in alternateButton! {
                tmpBtn.activateButton(bool: false)
            }
        }
        else{
            activateButton(bool: true)
        }
    }
    
    func activateButton(bool:Bool){
        isOn = bool
        
        let switch_color = bool ? UIColor.blue : UIColor.gray
        self.backgroundColor = switch_color
    }
}
