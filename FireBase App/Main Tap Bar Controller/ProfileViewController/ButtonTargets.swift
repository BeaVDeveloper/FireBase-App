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
    
    @objc func handleEditProfileOrFollow() {
        print("Follow")
        
        editProfileFollowBtn.animateTap()
        
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        
        guard let userId = user?.uid else { return }
        
        if editProfileFollowBtn.titleLabel?.text == "Unfollow" {
            //unfollow
            Database.database().reference().child("following").child(currentLoggedInUserId).child(userId).removeValue { (err, ref) in
                
                if let err = err {
                    print("Failed to unfollow user: ", err)
                    return
                }
                
                print("Successfully unfollowed user: ", self.user?.username ?? "")
                
                self.setupFollowStyle()
            }
            
        } else if editProfileFollowBtn.titleLabel?.text == "Follow" {
            //follow
            let ref = Database.database().reference().child("following").child(currentLoggedInUserId)
            
            let values = [userId: 1]
            
            ref.updateChildValues(values) { (err, ref) in
                if let err = err {
                    print("Failed to follow user: ", err)
                    return
                }
                
                print("Successfully followed user: ", self.user?.username ?? "")
                
                self.editProfileFollowBtn.setTitle("Unfollow", for: .normal)
                self.editProfileFollowBtn.backgroundColor = .white
                self.editProfileFollowBtn.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    
    func setupFollowStyle() {
        self.editProfileFollowBtn.setTitle("Follow", for: .normal)
        self.editProfileFollowBtn.backgroundColor = #colorLiteral(red: 0.05882352941, green: 0.6039215686, blue: 0.9294117647, alpha: 1)
        self.editProfileFollowBtn.setTitleColor(.white, for: .normal)
        self.editProfileFollowBtn.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
    }
}
