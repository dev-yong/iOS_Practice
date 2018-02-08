//
//  CircleViewModel.swift
//  RxSwiftExample
//
//  Created by 이광용 on 2018. 2. 7..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CirCleViewModel {
    var centerVariable = Variable<CGPoint?>(.zero) // Observer와 Observable 둘 다로 사용하기 위해 Subject. BehaviorSubject(Subject에 의해 반환한 가장 최근 값)
    var backgroundColorObservable: Observable<UIColor>! // Create observable that will change backgroundColor based on center
    
    init() {
        setup()
    }
    
    func setup() {
    }
}
