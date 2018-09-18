//
//  CustomTextField.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 12..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    //MARK:- Property
    //MARK: Variable
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var imageSize: Int = 20 {
        didSet{
            updateView()
        }
    }
    @IBInspectable var color:UIColor? = UIColor.black {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var imagePadding: Int = 0
    
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }

    //MARK:- Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        initTextField()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTextField()
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += CGFloat(imagePadding)
        return textRect
    }
    
    func initTextField()
    {
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        self.textColor = UIColor.white
        self.font = .systemFont(ofSize: 18)
        self.customLayer()
        self.clearButtonMode = .always
        //self.addBorderBottom(height: 1.0, color: .white)
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize + 20, height: imageSize))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextFieldViewMode.never
            leftView = nil
        }
        
        self.textColor = color
        
        // Placeholder text color
        guard let placeText = self.placeholder else {return }
        self.attributedPlaceholder = NSAttributedString(string: placeText,
                                                   attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
    }

}


