//
//  Comment.swift
//  FireBase App
//
//  Created by Yura Velko on 1/21/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit


struct Comment {
    
    let user: User
    
    let text: String
    let uid: String
    
    init(user: User,dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.user = user
    }
}
