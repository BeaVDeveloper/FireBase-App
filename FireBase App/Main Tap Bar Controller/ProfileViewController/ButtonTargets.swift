//
//  ButtonTargets.swift
//  FireBase App
//
//  Created by Yura Velko on 12/26/18.
//  Copyright © 2018 Yura Velko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

extension ProfileViewController {
    
   
    @objc func handleLogOut() {
        
        let alert = UIAlertController(title: nil, message: nil,preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive,handler: {(_) in

            do {
                try Auth.auth().signOut()
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle:nil)
                let login = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LogInViewController
                self.present(login, animated: true, completion: nil)
                
                print("Successfully log out")
            } catch let signOutErr {
                print("Failed to sign out: ", signOutErr)
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

        present(alert, animated: true, completion: nil)
    }
}


extension HeaderView {
    @objc func handlePhoto() {
        print("PHOTO")
    }
    
    @objc func handleEdit() {
        print("EDIT")
    }
}
