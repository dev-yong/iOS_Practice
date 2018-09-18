//
//  StudentListMVVMViewController.swift
//  MVC2MVVM
//
//  Created by 이광용 on 2018. 7. 27..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StudentListMVVMViewController: UIViewController, UITableViewDelegate{
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var subject = PublishSubject<Void>()
    var viewModel: StudentListViewModel = StudentListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        
        
//        self.viewModel.reloadStudentList = { [weak self] () in
//            guard let `self` = self else {return}
//            self.tableView.reloadData()
//        }
        
        
        viewModel.students.asObservable().subscribe(onNext: {print($0)}).disposed(by: disposeBag)
    
        
        self.button.rx.tap.bind(to: subject).disposed(by: disposeBag)
        subject.subscribe(onNext: { [weak self]_ in
            guard let `self` = self else {return}
            if let name = self.textField1.text,
                let address = self.textField2.text {
                
            }
        }).disposed(by: disposeBag)
        
        viewModel.students.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "StudentTableViewCell", cellType: StudentTableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        
        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "StudentTableViewCell", cellType: StudentTableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)

    }
    
    
    
//    @IBAction func addDataAction(_ sender:UIButton) {
//        guard let name = self.textField1.text else {return}
//        guard let address = self.textField2.text else {return}
//        if !name.isEmpty && !address.isEmpty {
//            viewModel.addStudentData(name: name, address: address)
//        }
//    }
}

//extension StudentListMVVMViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell") as! StudentTableViewCell
//        cell.studentObject = self.viewModel.studentArray?[indexPath.row]
//        return cell
//    }
//}
//
