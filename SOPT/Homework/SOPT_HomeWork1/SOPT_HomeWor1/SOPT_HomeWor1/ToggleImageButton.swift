//
//  ToggleImageButton.swift
//  SOPT_HomeWor1
//
//  Created by 이광용 on 2017. 9. 24..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ToggleImageButton: ToggleButton {
    var off_defaultImage : UIImage?
    var on_defaultImage : UIImage?
    
    convenience init(type buttonType: UIButtonType){
        self.init(type: buttonType)
    }
    override func initButton()
    {
        self.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    override func activateButton(bool: Bool) {
        isOn = bool
        
        let switch_Image = bool ? on_defaultImage : off_defaultImage
        self.setBackgroundImage(switch_Image, for: .normal)
    }
}
