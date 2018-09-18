//
//  ContentDetailViewController.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 17..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ContentDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeNumLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var profileImg: RoundedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var contentDetail: ContentInfo!
    var pid: Int = 0
    var like = "♥︎"
    var dislike = "♡"
    let header: HTTPHeaders = ["token": UserDefaults.standard.string(forKey: "token")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        // Do any additional setup after loading the view.
    }
    
    func initViewController()
    {
        likeButton.customLayer()
        
        let network = NetworkManager(self)
        
        let addURL: String = String(UserDefaults.standard.integer(forKey: "uid"))+"/" + String(pid)
        network.netWorkingResponseJSON(addURL: "appContent/info/" + addURL,
                                       method: .get,
                                       parameter: nil,
                                       header: header,
                                       code:"Detail")
    }
    
    @IBAction func likeButtonTouchUp(_ sender: UIButton) {
        let network = NetworkManager(self)
        let par = ["uid": UserDefaults.standard.integer(forKey: "uid"),
                   "pid": pid]
        if(likeButton.titleLabel?.text == dislike){
            network.netWorkingResponseJSON(addURL: "appLike",
                                           method: .post,
                                           parameter: par,
                                           header: header,
                                           code:"Like")
        }
        else{
            network.netWorkingResponseJSON(addURL: "appLike",
                                           method: .delete,
                                           parameter: par,
                                           header: header,
                                           code:"Like")
        }
        
    }
    
    
}

extension ContentDetailViewController : NetworkCallBack
{
    func networkResultData(resultData: Data, code: String) {
        if code == "Detail"{
            let decoder = JSONDecoder()
            do{
                let value = try decoder.decode(ContentInfo.self, from: resultData)
                contentDetail = value
                titleLabel.text = value.title
                dateLabel.text = value.date
                likeButton.titleLabel?.text = (value.p_isLike == 1 ? like:dislike)
                likeNumLabel.text = String(value.likeNum)
                contentTextView.text = value.content
                var image = #imageLiteral(resourceName: "ic_male_check")
                if let urlString = value.profileImg{
                    if let url = URL(string: urlString){
                        let data = try? Data(contentsOf: url)
                        if let imageData = data {
                            image = UIImage(data: imageData)!
                        }
                    }
                }
                profileImg.image = image
                nameLabel.text = value.name
            }
            catch(let err){
                print(err.localizedDescription)
            }
        }
        else if code == "Like"{
            let data = JSON(resultData)
            if data["msg"] == "success"{
                initViewController()
            }
        }
    }
    
    func networkFailed(msg: Any?) {
        print(msg)
    }
    
    
}
