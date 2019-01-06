//
//  AnimationsExt.swift
//  FireBase App
//
//  Created by Yura Velko on 12/22/18.
//  Copyright © 2018 Yura Velko. All rights reserved.
//

import UIKit

extension LogInViewController {
    func animationSignin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            UIView.animate(withDuration: 1, animations: {
                self.emailTextField.alpha = 1; self.emailTextField.isEnabled = true; self.emailView.alpha = 1; self.emailImage.alpha = 1
                self.passwordTextField.alpha = 1; self.passwordTextField.isEnabled = true; self.passView.alpha = 1; self.passImage.alpha = 1
                self.logInButton.alpha = 0.5; self.forgotPassButton.alpha = 1; self.forgotPassButton.isEnabled = true
                self.askLabel.alpha = 1; self.signUpButton.alpha = 1; self.signUpButton.isEnabled = true
            })
        }
    }
    
    func setAlphaLogin() {
        logInButton.alpha = 0; emailTextField.alpha = 0; emailView.alpha = 0; emailImage.alpha = 0; signUpButton.alpha = 0
        passwordTextField.alpha = 0; passImage.alpha = 0; passView.alpha = 0
        forgotPassButton.alpha = 0; askLabel.alpha = 0;
    }
}

extension SignUpViewController {
    func setAlphaSignUp() {
        emailTextField.alpha = 0; nameTextField.alpha = 0; passwordTextField.alpha = 0
        repeatPassTextField.alpha = 0; showPassBtn.alpha = 0; signUpButton.alpha = 0;
        cancelButton.alpha = 0; emailImage.alpha = 0; emailView.alpha = 0
        nameImage.alpha = 0; nameView.alpha = 0; passImage.alpha = 0
        passView.alpha = 0; repeatPassImage.alpha = 0; repeatPassView.alpha = 0
    }
    
    func animationSignUp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            UIView.animate(withDuration: 1, animations: {
                self.cancelButton.alpha = 1; self.cancelButton.isEnabled = true;
                self.emailTextField.alpha = 1; self.emailTextField.isEnabled = true; self.emailImage.alpha = 1; self.emailView.alpha = 1
                self.nameTextField.alpha = 1; self.nameTextField.isEnabled = true; self.nameImage.alpha = 1; self.nameView.alpha = 1
                self.passwordTextField.alpha = 1; self.passwordTextField.isEnabled = true; self.passImage.alpha = 1; self.passView.alpha = 1
                self.repeatPassTextField.alpha = 1; self.repeatPassTextField.isEnabled = true; self.repeatPassView.alpha = 1; self.repeatPassImage.alpha = 1
                self.showPassBtn.alpha = 1; self.showPassBtn.isEnabled = true;
                self.signUpButton.alpha = 0.5; self.signUpButton.isEnabled = false
            })
        }
    }
}

