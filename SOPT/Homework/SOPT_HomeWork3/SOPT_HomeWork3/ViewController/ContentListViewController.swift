//
//  ContentListViewController.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 16..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

class ContentListViewController: UIViewController {
    //MARK:- Property
    @IBOutlet weak var contentTableView: UITableView!
    var contentTitleList:[ContentInfo]!
    
    //MARK:- Method
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        syncFunction()
    }
    
    //MARK: Function
    @IBAction func syncButtonTouchUp(_ sender: UIBarButtonItem) {
        syncFunction()
    }
    
    func syncFunction()
    {
        let network = NetworkManager(self)
        if let token = UserDefaults.standard.string(forKey: "token"){
            network.netWorkingResponseJSON(addURL: "appContent/" + String(UserDefaults.standard.integer(forKey: "uid")),
                                           method: .get,
                                           parameter: nil,
                                           header: ["token": token], code:"sync")
        }
    }
}

//MARK:- Extension
//MARK: Table Extension
extension ContentListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.contentTitleList{
            return list.count
        }
        else {return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let item = contentTitleList[indexPath.row]
        cell.info = item
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc:ContentDetailViewController = storyBoard.instantiateViewController(withIdentifier: "ContentDetailViewController") as? ContentDetailViewController else {return}
        //SecondViewController의 [identity]-[Storyboard ID] 설정 필수!
        vc.pid = contentTitleList[indexPath.row].pid
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Network Extension
extension ContentListViewController: NetworkCallBack
{
    func networkResultData(resultData: Data, code: String) {
        debugPrint(resultData)
        let decoder = JSONDecoder()
        do{
            let value = try decoder.decode([ContentInfo].self, from: resultData)
            contentTitleList = value
            self.contentTableView.reloadData()
        }
        catch(let err){
            print(err.localizedDescription)
        }
        
    }
    
    func networkFailed(msg: Any?) {
        debugPrint(msg ?? "Error")
    }
    
    
}
