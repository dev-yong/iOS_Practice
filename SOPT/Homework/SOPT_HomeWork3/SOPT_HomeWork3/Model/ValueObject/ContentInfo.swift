//
//  ContentInfo.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 16..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation

struct ContentInfo: Codable{
    let pid: Int
    let title: String
    let content: String?
    let likeNum:Int
    let uid: Int
    let profileImg: String?
    let name: String
    let date:String
    let p_isLike:Int
}
