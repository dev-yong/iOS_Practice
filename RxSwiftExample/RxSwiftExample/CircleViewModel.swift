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
    var centerVariable = Variable<CGPoint?>(.zero)
    /*
     centerVariable은 현재 위치의 중앙점에 대하여 관찰하기 때문에 observer이며, ViewModel에 의하여 관찰당하기 때문에 observable이 된다.
     observer, observable 의 두 가지 속성을 띄고 있어 subject가 된다.
     subject 중에서도, Subject 에 의해 반환한 가장 최근 값을 갖는 BehaviorSubject(Variable) 속성을 택한다
     */
    var backgroundColorObservable: Observable<UIColor>! // Create observable that will change backgroundColor based on center
    fileprivate var disposeBag: DisposeBag = DisposeBag()

    init() {
        setup()
    }
    
    func setup() {
        backgroundColorObservable = centerVariable.asObservable().map({ (center) -> UIColor in
            guard let center = center else {return UIColor.black}
            let red:CGFloat = ( ( center.x + center.y ).truncatingRemainder(dividingBy: 255.0) ) / 255.0
            let green:CGFloat = ( center.x.truncatingRemainder(dividingBy: 255.0) ) / 255.0
            let blue:CGFloat = ( center.y.truncatingRemainder(dividingBy: 255.0) ) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1)
        })
    }
}
