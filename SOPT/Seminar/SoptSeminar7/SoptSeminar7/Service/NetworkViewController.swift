//
//  NetworkViewController.swift
//  SoptSeminar7
//
//  Created by 이광용 on 2017. 12. 11..
//  Copyright © 2017년 kanghoon. All rights reserved.
//

import UIKit

class NetworkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData<S: Gettable>(service: S) where S.T == [Model] {
        service.get { (result) in
            switch result{
            case .Success(let data) :
                break
            case .Failure(let err) :
                break
            }
        }
    }
    
}
