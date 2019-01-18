//
//  LogInViewController.swift
//  FireBase App
//
//  Created by Yura Velko on 12/21/18.
//  Copyright © 2018 Yura Velko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LogInViewController: UIViewController {
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var askLabel: UILabel!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var passImage: UIImageView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passView: UIView!
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        setAlphaLogin(); animationSignin()
        setUpPlaceholders(); textFieldsTarget()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        logInButton.animateTap()
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let _ = error {
                
                let alert = UIAlertController(title: "Wrong data", message: "Wrong email or password, please check it", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            if Auth.auth().currentUser != nil {
                print("Successfully signed in: ", uid)
               
                let home = MainTabBarController()
                self.present(home, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func forgotPassButton(_ sender: UIButton) {
        forgotPassButton.animateTap()
        var textField = UITextField()
        
        let successAlert = UIAlertController(title: "Successfully reset password", message: "Check your email", preferredStyle: .alert)
        let successAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let alert = UIAlertController(title: "Forgot password?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let sendAction = UIAlertAction(title: "Send", style: .default) { (_) in
            
            guard let email = textField.text else { return }
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                if let err = error {
                    print("Failed to reset password: ", err)
                    return
                }
                print("Successfully reset password")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.present(successAlert, animated: true, completion: nil)
                }
                return
            })
        }
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Enter your email here"
        }
        alert.addAction(sendAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        successAlert.addAction(successAction)
    }
}
