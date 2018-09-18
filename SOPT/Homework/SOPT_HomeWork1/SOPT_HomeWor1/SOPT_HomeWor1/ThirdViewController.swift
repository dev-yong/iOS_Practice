//
//  ThirdViewController.swift
//  SOPT_HomeWor1
//
//  Created by 이광용 on 2017. 9. 23..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var id_Content: UILabel!
    @IBOutlet weak var pw_Content: UILabel!
    @IBOutlet weak var name_Content: UILabel!
    @IBOutlet weak var age_Content: UILabel!
    @IBOutlet weak var gender_Image: UIImageView!
    
    var _id = ""
    var _pw = ""
    var _name = ""
    var _age = ""
    var _gender = #imageLiteral(resourceName: "ic_male_check")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        id_Content.text = _id
        pw_Content.text = _pw
        name_Content.text = _name
        age_Content.text = _age
        gender_Image.image = _gender
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func GoFirstVC(_ sender: Any) {
        guard let window = UIApplication.shared.keyWindow else{return }
        
        window.rootViewController = UINavigationController(rootViewController: FirstViewController())
    }
    
    @IBAction func Alert_Action(_ sender: Any) {
        let alertController = UIAlertController(title: "알림", message: "알림창입니다", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "확인", style: .default, handler: {(UIAlertAction) in print("확인되었습니다")})
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func ActionSheet(_ sender: Any) {
       let alertController = UIAlertController(title: "알림", message: "알림창입니다", preferredStyle: .actionSheet)
        let doneAction = UIAlertAction(title: "확인", style: .default, handler: {(UIAlertAction) in print("확인되었습니다")})
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
