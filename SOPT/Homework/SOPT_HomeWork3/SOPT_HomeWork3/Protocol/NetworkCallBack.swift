//
//  NetworkCallBack.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 14..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation

protocol NetworkCallBack{
    func networkResultData(resultData: Data, code: String)
    func networkFailed(msg: Any?)
}
