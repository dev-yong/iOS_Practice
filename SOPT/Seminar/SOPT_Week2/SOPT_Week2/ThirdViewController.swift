//
//  ThirdViewController.swift
//  SOPT_Week2
//
//  Created by 이광용 on 2017. 10. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    //MARK:- Methods
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToFirst" {
            print("unwindToFirst")
        }
    }
    
    //MARK: IBAction Methods
    @IBAction func comeBackAction(_sender : UIButton){
        //declare Alert controller
        let alertController = UIAlertController(title: "알림", message: "첫 화면으로 돌아가시겠습니까?", preferredStyle: .alert)
        //declare Alert Action
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: {(uialertaction) in
        self.performSegue(withIdentifier: "unwindToFirst", sender: nil)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func moveFirstViewContrllerBtn(sender : UIButton){
        let presentingController = self.presentingViewController as? UITabBarController
        dismiss(animated: false, completion: {
            let navi = presentingController?.childViewControllers[0] as? UINavigationController
            navi?.popViewController(animated: false)
            })
    }

}
