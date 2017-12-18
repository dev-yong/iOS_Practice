//
//  ViewController.swift
//  SOPT_Week2
//
//  Created by 이광용 on 2017. 10. 27..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Properties
    var id = 0
    
    //MARK:- Method
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: IBAction Methods
    @IBAction func moveViewControllerBtn(sender: UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondViewController:SecondViewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {return}
        //SecondViewController의 [identity]-[Storyboard ID] 설정 필수!
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    @IBAction func unwindViewController(segue:UIStoryboardSegue){}
}

