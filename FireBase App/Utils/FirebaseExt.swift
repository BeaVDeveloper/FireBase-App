//
//  FirebaseExt.swift
//  FireBase App
//
//  Created by Yura Velko on 1/14/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

extension Database {
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
            
        }) { (err) in
            print("Failed to fecth user for posts: ", err)
        }
    }
}
