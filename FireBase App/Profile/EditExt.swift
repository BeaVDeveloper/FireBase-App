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
        
        guard let name = nameTextField.text else { return }
        guard let uid = user?.uid else { return }
        guard let email = user?.email else { return }
        
        let currentData = currentImageView.image?.jpegData(compressionQuality: 0.3)
        let changedData = imageView.image?.jpegData(compressionQuality: 0.3)
        
        if currentData != changedData {
            Database.saveImageToDB(uid: uid, data: changedData, name: name, email: email) {
                self.dismiss(animated: true, completion: nil)
            }
            
        } else {
            let values = ["username": name]
            Database.saveUserValues(uid: uid, values: values) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func changeEmail() {
        let emailChangeVC = EmailChange()
        emailChangeVC.user = user
        let navController = UINavigationController(rootViewController: emailChangeVC)
        present(navController, animated: false, completion: nil)
    }
}
