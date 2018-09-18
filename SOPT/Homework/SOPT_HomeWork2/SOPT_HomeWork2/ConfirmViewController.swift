//
//  ConfirmViewController.swift
//  SOPT_HomeWork2
//
//  Created by 이광용 on 2017. 10. 30..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    //MARK:- Properties
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pwLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderImage: UIImageView!
    
    //MARK:- Variables
    var people: People?
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        // Do any additional setup after loading the view.
    }

    func setData(){
        self.idLabel.text = people?.id
        self.pwLabel.text = people?.pw
        self.nameLabel.text = people?.name
        self.ageLabel.text = people?.age
        self.genderImage.image = people?.gender
    }
    
    //MARK:- IBAction
    @IBAction func combackBtnTouchUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToMain", sender: nil)
    }
    

}
