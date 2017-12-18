//
//  FirstViewController.swift
//  SOPT_HomeWor1
//
//  Created by 이광용 on 2017. 9. 23..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var id_TextField: UITextField!
    @IBOutlet weak var pw_TextField: UITextField!
    
    let alertController = UIAlertController(title: "경고", message: "ID 또는 PW를 입력해주세요", preferredStyle: .alert)
    let successController = UIAlertController(title: "성공", message: "로그인에 성공하였습니다.", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start")
        let cancelAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        successController.addAction(cancelAction)
    }
    
    @IBAction func LogIn_Action(_ sender: UIButton) {
        
        if(id_TextField.text?.NilOrEmpty())!{
            self.present(alertController, animated: true, completion: nil)
        }
        else if(pw_TextField.text?.NilOrEmpty())!{
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            self.present(successController, animated: true, completion: nil)
        }
    }
    @IBAction func Register_Action(_ sender: Any) {
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    func NilOrEmpty()->Bool{
        if(self.trim().isEmpty){return true}
        else{return false}
    }
}
