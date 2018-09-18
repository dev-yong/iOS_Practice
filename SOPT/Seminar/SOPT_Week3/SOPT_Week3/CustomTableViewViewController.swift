//
//  CustomTableViewViewController.swift
//  SOPT_Week3
//
//  Created by 이광용 on 2017. 10. 28..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class CustomTableViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    //MARK: Property
    @IBOutlet weak var tableView: UITableView!
    var tableViewRefreshControll: UIRefreshControl?
    var cellInfoList = [CellInfo]()
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let info1 = CellInfo(imageName: "ic_female", title: "여자", subTitle: "여자 이미지 파일")
        let info2 = CellInfo(imageName: "ic_female_check", title: "여자 체크", subTitle: "여자 체크 이미지 파일")
        let info3 = CellInfo(imageName: "ic_male", title: "남자", subTitle: "남자 이미지 파일")
        let info4 = CellInfo(imageName: "ic_male_check", title: "남자 체크", subTitle: "남자 체크 이미지 파일")
        cellInfoList.append(info1)
        cellInfoList.append(info2)
        cellInfoList.append(info3)
        cellInfoList.append(info4)
        tableView.tableFooterView = UIView(frame: CGRect.zero)//TableView 밑의 선 지우기 위한 선언
        tableViewRefreshControll = UIRefreshControl()
        tableView.refreshControl = tableViewRefreshControll
        tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
    }
    
    @objc func startReloadTableView(_ sender:UIRefreshControl){
        //network model
        self.tableView.reloadData()
        sender.endRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableView Delegate redeclare
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellInfoList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as! CustomTableViewCell
        //CustomTableViewCell로 강제 캐스팅해주지 않으면, UITableViewCell로 캐스팅되어 내부 property를 접근할 수 없다.
        //cell.customImageView.image = UIImage(named: "ic_male")
        //cell.nameLabel.text = "\(indexPath.section)"
        //cell.pwLabel.text = "\(indexPath.row)"
        //---간략화---
        //cell.customImageView.image = UIImage(named: item.imageName)
        //cell.nameLabel.text = item.title
        //cell.pwLabel.text = item.subTitle
        //---ViewCell에 선언을 통하여 간략화---
        let item = cellInfoList[indexPath.row]
        cell.info = item
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        print(cell.nameLabel.text)
    }
}
