//
//  CustomExtension.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 12..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func customLayer()
    {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 2.0
    }
    
    func shake(_ value: Double) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-value, value, -value*(2/3), value*(2/3), -value*(1/3), value*(1/3), 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces).trimmingCharacters(in: CharacterSet.newlines)
    }
    func NilOrEmpty()->Bool{
        if(self.trim().isEmpty){return true}
        else{return false}
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

