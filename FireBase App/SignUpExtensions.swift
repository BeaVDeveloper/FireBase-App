//
//  Extensions.swift
//  FireBase App
//
//  Created by Yura Velko on 12/20/18.
//  Copyright © 2018 Yura Velko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

extension SignUpViewController {
    
    func setUpPlaceholders() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)])
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)])
        
        repeatPassTextField.attributedPlaceholder = NSAttributedString(string: "Repeat password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)])
    }
    
    func textFieldsTarget() {
        emailTextField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        repeatPassTextField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
    }
    
    @objc func handleTextInput() {
        
        let isFormValid = emailTextField.text?.count ?? 0 > 0 &&
        nameTextField.text?.count ?? 0 > 0 &&
        passwordTextField.text?.count ?? 0 > 0 &&
        repeatPassTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 1, green: 0.4784313725, blue: 0.2549019608, alpha: 1)
            signUpButton.alpha = 1
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = #colorLiteral(red: 1, green: 0.4784313725, blue: 0.2549019608, alpha: 0.5)
            signUpButton.alpha = 0.5
        }
    }
    
    func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let name = nameTextField.text else { return }
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            if let err = error {
                print("Failed to create a user: ", err)
                return
            }
            print("Successfully create a user: ", uid)
            
            let image = #imageLiteral(resourceName: "icons8-decision-100")
            
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            
            Database.saveImageToDB(uid: uid, data: uploadData, name: name, email: email, completion: {
                
                let home = MainTabBarController()
                self.present(home, animated: true, completion: nil)
            })
        }
    }
}


