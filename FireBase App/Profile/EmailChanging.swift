//
//  EmailChanging.swift
//  FireBase App
//
//  Created by Yura Velko on 1/26/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit
import Firebase

class EmailChange: UIViewController, UITextFieldDelegate {
    
    var user: User? {
        didSet {
            emailTextField.text = user?.email.lowercased()
        }
    }
    
    let emailTextField = CustomTextField(txt: "Enter email", keyType: .done)
    let emailImage = CustomImageView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let emailSeparatorView = UIView()
        emailSeparatorView.backgroundColor = #colorLiteral(red: 0.007513592951, green: 0.5695900321, blue: 0.8627313972, alpha: 1)
        emailImage.image = #imageLiteral(resourceName: "icons8-secured-letter-51")
        emailTextField.delegate = self
        
        navigationItem.title = "Change Email"
        
        view.addSubview(emailSeparatorView)
        view.addSubview(emailTextField)
        view.addSubview(emailImage)
        emailImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        emailTextField.anchor(top: nil, left: emailImage.rightAnchor, bottom: emailImage.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 15)
        emailSeparatorView.anchor(top: emailTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 1)
        
        emailTextField.becomeFirstResponder()
        
        setupNavButtons()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleDone()
        return true
    }
    
    private func setupNavButtons() {
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-delete-50"), style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-checkmark-50"), style: .plain, target: self, action: #selector(handleDone))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.4849936962, blue: 0.8672267795, alpha: 1)
    }
    
    @objc func handleCancel() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func handleDone() {
        guard let uid = user?.uid else { return }
        guard let email = emailTextField.text else { return }
        
        if email != user?.email.lowercased() {
            
            let alert = UIAlertController(title: "Changing Email", message: "Are you sure want to change email? We will send a confirming letter on your email", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                
                Auth.auth().currentUser?.updateEmail(to: email, completion: { (err) in
                    if let err = err {
                        print("Failed to update email: ", err)
                        return
                    }
                    let values = ["email": email]
                    Database.saveUserValues(uid: uid, values: values, completion: {
                        print("Successfully update email")
                        self.dismiss(animated: true, completion: nil)
                    })
                })
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
