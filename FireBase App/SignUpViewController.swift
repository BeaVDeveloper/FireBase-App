//
//  ViewController.swift
//  FireBase App
//
//  Created by Yura Velko on 12/20/18.
//  Copyright © 2018 Yura Velko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPassTextField: UITextField!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var nameImage: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var passImage: UIImageView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var repeatPassImage: UIImageView!
    @IBOutlet weak var repeatPassView: UIView!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAlphaSignUp(); animationSignUp()
        textFieldsTarget(); setUpPlaceholders()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    @IBAction func showPassButton(_ sender: UIButton) {
        showPassBtn.animateTap()
        
        if passwordTextField.text?.count != 0 || repeatPassTextField.text?.count != 0 {
            if passwordTextField.isSecureTextEntry == true || repeatPassTextField.isSecureTextEntry == true {
                passwordTextField.isSecureTextEntry = false
                repeatPassTextField.isSecureTextEntry = false
                showPassBtn.setTitle("Hide password", for: .normal)
            } else {
                passwordTextField.isSecureTextEntry = true
                repeatPassTextField.isSecureTextEntry = true
                showPassBtn.setTitle("Show password", for: .normal)
            }
        }
    }
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
        signUpButton.animateTap()
        if passwordTextField.text == repeatPassTextField.text {
            if (passwordTextField.text?.count)! >= 6 &&
                (repeatPassTextField.text?.count)! >= 6 &&
                (passwordTextField.text?.count)! <= 12 &&
                (repeatPassTextField.text?.count)! <= 12 {
                
                handleSignUp()
                
            } else {
                let alert = UIAlertController(title: "Wrong data", message: "Password length must be 6-12 characters", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
            
        } else {
            print("Passwords do not match, please check it")
            let alert = UIAlertController(title: "Wrong data", message: "Passwords do not match, or email is wrong, please check it", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        cancelButton.animateTap()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let login = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LogInViewController
        present(login, animated: true, completion: nil)
    }
}
