//
//  ViewController.swift
//  FCM
//
//  Created by 이광용 on 2018. 2. 26..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        PhoneAuthProvider.provider().verifyPhoneNumber("01071076604", uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print(error)
                return
            }
            // Sign in using the verificationID and the code sent to the user
            // ...
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

