//
//  User.swift
//  FireBase App
//
//  Created by Yura Velko on 1/8/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit

struct User {
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
