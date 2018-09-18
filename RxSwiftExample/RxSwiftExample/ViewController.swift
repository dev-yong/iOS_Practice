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
    
    let observable = Observable.of(1,2,3)
    let observable2 = Observable.of(2,3)
    let subject = PublishSubject<Int>() // observer 이다. Publish, Behavior, Replay 들의 종류가 있다.
    /*
     PublishSubject : subsribe 이후의 것을 받는다. ex. 일반적인 리퀘스트
     BehaviorSubject : subsribe 전의 마지막 것부터 받는다. ex. profile
     ReplaySubejct : subsribe 전의 것을 bufferSize부터 받는다.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //------------------------------------------
        observable.subscribe(onNext: { (num) in
            print(num)
        }, onDisposed: {
            print("dispose")
        }).disposed(by: disposeBag)
        //------------------------------------------
        subject.subscribe(onNext: { (num) in
            print(num)
        }).disposed(by: disposeBag)
        subject.on(.next(1))
        //------------------------------------------
        let stringObservable = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("1")
            observer.onCompleted()
            return Disposables.create()
        }
        //------------------------------------------
        //operator : combineLatest, zip, merge...
        Observable.combineLatest(observable, observable2)
            .subscribe(onNext: { (num1, num2) in
            }).disposed(by: disposeBag)
        //------------------------------------------
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
