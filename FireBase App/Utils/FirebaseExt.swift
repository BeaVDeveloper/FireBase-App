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
    
    static func saveUserValues(uid: String, values: [String: Any] ,completion: @escaping () -> ()) {
        
        Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
            
            if let err = error {
                print("Failed to save user in db: ", err)
                return
            }
            completion()
        })
    }
    
    static func saveImageToDB(uid: String, data: Data?, name: String, email: String, completion: @escaping () -> ()) {
        
        guard let uploadData = data else { return }
        
        let filename = NSUUID().uuidString
        let storageItem = Storage.storage().reference().child("users").child(filename)
        
        storageItem.putData(uploadData, metadata: nil) { (_, err) in
            
            storageItem.downloadURL(completion: { (url, err) in
                if let err = err {
                    print("Failed to upload image: ", err)
                    return
                }
                guard let imageUrl = url?.absoluteString else { return }
                print("Successfully uploaded image: ", imageUrl)
                
                let values = ["username": name, "email": email, "profileImageUrl": imageUrl]
                
                Database.saveUserValues(uid: uid, values: values, completion: {})
                completion()
            })
        }
    }
}
