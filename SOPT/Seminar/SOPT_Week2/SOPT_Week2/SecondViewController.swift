//
//  SecondViewController.swift
//  SOPT_Week2
//
//  Created by 이광용 on 2017. 10. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
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
    
    //MARK: IBAcion Methods
    @IBAction func moveViewControllerBtn(sender:UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let thirdViewController = storyBoard.instantiateViewController(withIdentifier: ThirdViewController.reuseIdentifier) as? ThirdViewController else {return}
        present(thirdViewController, animated: true, completion: nil)
    }
    

}
