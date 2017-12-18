//
//  SecondViewController.swift
//  SOPT_HomeWor1
//
//  Created by 이광용 on 2017. 9. 23..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var male_Button: ToggleButton!
    
    @IBOutlet weak var female_Button: ToggleButton!
    
    @IBOutlet weak var male_Image_Button :  ToggleImageButton!
    
    @IBOutlet weak var female_Image_Button: ToggleImageButton!
    
    @IBOutlet weak var id_Field: UITextField!
    @IBOutlet weak var pw_Field: UITextField!
    @IBOutlet weak var name_Field: UITextField!
    @IBOutlet weak var age_Field: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToggleSet()
        ToggleImageSet()
    }
    func ToggleSet(){
        male_Button?.alternateButton = [female_Button!]
        female_Button?.alternateButton=[male_Button!]
    }
    func ToggleImageSet(){
        male_Image_Button.off_defaultImage = #imageLiteral(resourceName: "ic_male")
        male_Image_Button.on_defaultImage = #imageLiteral(resourceName: "ic_male_check")
        female_Image_Button.off_defaultImage = #imageLiteral(resourceName: "ic_female")
        female_Image_Button.on_defaultImage = #imageLiteral(resourceName: "ic_female_check")
        male_Image_Button.alternateButton = [female_Image_Button!]
        female_Image_Button.alternateButton =
        [male_Image_Button!]
    }
    
    @IBAction func Dismiss_Action(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Submit_Action(_ sender: Any) {
        let Third_VC = ThirdViewController()
        guard let id = id_Field.text else {return }
        guard let pw = pw_Field.text else {return }
        guard let name = name_Field.text else {return }
        guard let age = age_Field.text else {return }
        Third_VC._id = id
        Third_VC._pw = pw
        Third_VC._name = name
        Third_VC._age = age
        
        if(male_Image_Button.isOn == true){
            Third_VC._gender = #imageLiteral(resourceName: "ic_male_check")
        }
        if(female_Image_Button.isOn == true){
            Third_VC._gender = #imageLiteral(resourceName: "ic_female_check")
        }
        
        self.present(Third_VC, animated: true, completion: nil)
    }
}
