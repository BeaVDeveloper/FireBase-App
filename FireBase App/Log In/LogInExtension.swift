//
//  LogInExtension.swift
//  FireBase App
//
//  Created by Yura Velko on 12/22/18.
//  Copyright © 2018 Yura Velko. All rights reserved.
//

import UIKit

extension LogInViewController {
    
    func setUpPlaceholders() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)])
    }
    
    func textFieldsTarget() {
        emailTextField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
    }
    
    @objc func handleTextInput() {
        
        let isFormValid = emailTextField.text?.count ?? 0 > 0 &&
            passwordTextField.text?.count ?? 0 > 0
        if isFormValid {
            logInButton.isEnabled = true
            logInButton.backgroundColor = #colorLiteral(red: 1, green: 0.4784313725, blue: 0.2549019608, alpha: 1)
            logInButton.alpha = 1
        } else {
            logInButton.isEnabled = false
            logInButton.backgroundColor = #colorLiteral(red: 1, green: 0.4784313725, blue: 0.2549019608, alpha: 0.5)
            logInButton.alpha = 0.5
        }
    }
}
