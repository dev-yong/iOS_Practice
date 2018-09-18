//
//  CustomBackgroundImageView.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 12..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class CustomBackgroundImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initBackgournd()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBackgournd()
    }
    
    func initBackgournd()
    {
        self.image = #imageLiteral(resourceName: "login_background")
        self.addBlurEffect()
        self.contentMode = .scaleAspectFill
    }

}

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds 
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

