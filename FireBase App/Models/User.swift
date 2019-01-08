//
//  User.swift
//  FireBase App
//
//  Created by Yura Velko on 1/8/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
