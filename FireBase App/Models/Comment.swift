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
    let creationDate: Date
    
    init(user: User,dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.user = user
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
