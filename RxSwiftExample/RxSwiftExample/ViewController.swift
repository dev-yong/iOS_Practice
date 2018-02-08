//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by 이광용 on 2018. 2. 7..
//  Copyright © 2018년 이광용. All rights reserved.
//  https://github.com/DroidsOnRoids/RxSwiftExamples/blob/master/Libraries%20Usage/RxSwiftExample/RxSwiftExample/ViewController.swift

import UIKit
import RxSwift
import RxCocoa

class TableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class ViewController: UIViewController {
    var shownCities: [String] = []
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag() // 뷰가 할당 해제될 때 놓아줄 수 있는 일회용품의 가방

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setUp(target: self, cell: TableViewCell.self)
        
        self.searchBar
            .rx.text // RxCocoa의 Observable 속성
            .orEmpty // 옵셔널이 아니도록 만듭니다.
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // 새로운 값이 이전의 값과 같은지 확인합니다.
            .filter { !$0.isEmpty } // 새로운 값이 정말 새롭다면, 비어있지 않은 쿼리를 위해 필터링합니다.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) } // 도시를 찾기 위한 “API 요청” 작업을 합니다.
                self.tableView.reloadData() // 테이블 뷰를 다시 불러옵니다.
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
        cell.title.text = shownCities[indexPath.row]
        return cell
    }
    
    
}
