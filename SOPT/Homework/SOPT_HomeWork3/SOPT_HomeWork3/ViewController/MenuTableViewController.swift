//
//  MenuTableViewController.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 15..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import SideMenu

class MenuTableViewController: UITableViewController {
    @IBOutlet weak var profileImageView: RoundedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        initMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initMenu(){
        let imageData = UserDefaults.standard.data(forKey: "profileImg")!
        profileImageView.image = UIImage(data: imageData)
        nameLabel.text = UserDefaults.standard.string(forKey: "name")
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "login_background")
        imageView.contentMode = .scaleAspectFill
        imageView.addBlurEffect()
        tableView.backgroundView = imageView        
    }
    @IBAction func logOutButtonTouchUp(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",
                                     style: .default,
                                     handler: {(UIAlertAction) in
                                        
                                        for key in UserDefaults.standard.dictionaryRepresentation().keys {
                                            UserDefaults.standard.removeObject(forKey: key)
                                        }
                                        
                                        self.performSegue(withIdentifier: "GoToLogInVeiwController", sender: nil)
        })
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cancleAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
}
