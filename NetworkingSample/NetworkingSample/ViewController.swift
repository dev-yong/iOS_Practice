//
//  ViewController.swift
//  NetworkingSample
//
//  Created by 이광용 on 2018. 9. 17..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        APIRouter.shared.request(UserService.search(uuid: 2)) { (code: Int?, user: User?) in
//            print(user)
//        }
        APIRouter.shared.request(UserService.get(page: 2)) { (code: Int?, users: UserList?) in
            print(users)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

