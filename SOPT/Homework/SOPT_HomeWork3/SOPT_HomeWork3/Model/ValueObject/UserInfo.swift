//
//  UserInfo.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 14..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation
import UIKit

struct UserInfo:Codable {
    let uid: Int
    let profileImg: Data
    let name: String
    let token: String
}
