//
//  StudentListViewModel.swift
//  MVC2MVVM
//
//  Created by 이광용 on 2018. 7. 27..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation
import RxSwift

class StudentListViewModel {
    var students = BehaviorSubject<[Student]>(value: [])
    

//    var studentArray: [Student]? = [] {
//        didSet {
//            reloadStudentList()
//        }
//    }
//    var reloadStudentList = {()->() in}
//    func addStudentData(name: String, address: String) {
//        self.studentArray?.append(Student(name: name, address: address))
//    }
}
