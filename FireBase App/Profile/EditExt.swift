//
//  EditExt.swift
//  FireBase App
//
//  Created by Yura Velko on 1/23/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit
import Firebase

extension EditProfileController {
    
    func setupView() {
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        imageView.layer.cornerRadius = 100 / 2
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(newPhotoButton)
        newPhotoButton.anchor(top: imageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        newPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.anchor(top: newPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(nameTextField)
        nameTextField.anchor(top: nameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        
        
        nameSeparatorView.backgroundColor = .lightGray
        view.addSubview(nameSeparatorView)
        nameSeparatorView.anchor(top: nameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 1)
        
        view.addSubview(emailLabel)
        emailLabel.anchor(top: nameSeparatorView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: emailLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        
        
        emailSeparatorView.backgroundColor = .lightGray
        view.addSubview(emailSeparatorView)
        emailSeparatorView.anchor(top: emailTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 1)
    }
    
    func setupNavigationButtons() {
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
    }
    
    
    
    @objc func handleCancel() {
        print("Cancel")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone() {
        print("Done")
    }
    
    
    @objc func chageEmail() {
        
        guard let email = emailTextField.text?.lowercased() else { return }
        
        if email != user?.email.lowercased() {
            
            let alert = UIAlertController(title: "Changing Email", message: "Are you sure want to change email? You will need to confirm it in your actual email", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Yes", style: .default) { (_) in
                
                print("Perform change email adress")
                
                Auth.auth().currentUser?.updateEmail(to: email, completion: { (err) in
                    if let err = err {
                        print("Failed to update email: ", err)
                        return
                    }
                    print("Successfully update email: ", email)
                })
            }
            
            let cancelAction = UIAlertAction(title: "No", style: .destructive) { (_) in
                self.emailTextField.text = self.user?.email.lowercased()
            }
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
