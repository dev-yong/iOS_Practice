//
//  GithubAPI.swift
//  Network
//
//  Created by 이광용 on 2018. 7. 21..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation

public enum GitHub {
    case zen
    case userProfile(String)
    case userRepositories(String)
}

extension GitHub: TargetType {
    
}
