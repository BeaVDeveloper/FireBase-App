//
//  Post.swift
//  FireBase App
//
//  Created by Yura Velko on 1/2/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import Foundation

struct Post {
    
    let user: User
    let imageUrl: String
   
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
