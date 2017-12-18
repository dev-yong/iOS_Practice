//
//  LogInViewController.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 12. 9..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
struct UserDataRequset: GraphRequestProtocol
{
//    var graphPath: String
//
//    var parameters: [String : Any]?
//
//    var accessToken: AccessToken?
//
//    var httpMethod: GraphRequestHTTPMethod
//
//    var apiVersion: GraphAPIVersion

    public let graphPath = "me"
    public let parameters: [String:Any]? = ["fields" : "id, email, name, picture{url}"]
    public let accessToken: AccessToken? = AccessToken.current
    public let httpMethod: GraphRequestHTTPMethod = .GET
    public let apiVersion: GraphAPIVersion = GraphAPIVersion.defaultVersion
    
    struct Response: GraphResponseProtocol{
            var id = ""
            var email = ""
            var name = ""
            var profileURL = ""
        init(rawResponse: Any?){
            if let data = rawResponse as? [String:Any]
            {
                if let id = data["id"]{
                    self.id = id as! String
                }
                if let email = data["email"]{
                    self.id = email as! String
                }
                
                if let name = data["name"]{
                    self.name = name as! String
                }
                
                if let profileURL = (data["picture"] as? [String: [String:String]])?["data"]?["url"]{
                    self.profileURL = profileURL
                }
                
            }
        }
    }
}

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchUpFBLogIn(_ sender: Any) {
      let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (logInResult) in
            switch logInResult{
            case .success(grantedPermissions: _, declinedPermissions: _, token: _) :
                self.getFaceBookUserData()
                self.goToNextVC()
                break
            case .failed(let err) :
                print(err.localizedDescription)
            case .cancelled :
                break
            }
        }
    }
    
    var userData: UserDataRequset.Response?
    func getFaceBookUserData()
    {
        //등록된 계정이 존재하는지. 로그아웃 시 서버로그아웃과 페이스북 토큰 삭제(로그아웃)을 같이해야함!!!! 중요!
        //[앱 검수] - 공개해야지 로그인 가능. 승인된 항목 설정 가능
        if let fbToken = FBSDKAccessToken.current(){
            
        }
        
        let connection = GraphRequestConnection()
        connection.add(UserDataRequset()) {
            (response: HTTPURLResponse?, result: GraphRequestResult<UserDataRequset>) in
            switch result {
            case .success(let graphResponse) :
                self.userData = graphResponse
                print(self.userData)
                break
            case .failed :
                break
            }
        }
        connection.start()
    }
    
    func goToNextVC()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabController = storyboard.instantiateViewController(withIdentifier: "MainTab") as! UITabBarController
        
        self.present(tabController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
