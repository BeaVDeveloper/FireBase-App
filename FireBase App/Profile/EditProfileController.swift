//
//  EditProfileController.swift
//  FireBase App
//
//  Created by Yura Velko on 1/23/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit
import Firebase


class EditProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var user: User? {
        didSet {
            guard let imageUrl = user?.profileImageUrl else { return }
            imageView.loadImage(urlString: imageUrl)
            nameTextField.text = user?.username
            emailTextField.text = Auth.auth().currentUser?.email
        }
    }
    
    lazy var imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor.black.cgColor
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return iv
    }()
    
    let newPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose another photo", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.setTitleColor(#colorLiteral(red: 0.007513592951, green: 0.5695900321, blue: 0.8627313972, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSelectPhoto() {
        print("Photo")
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = editedImage.withRenderingMode(.alwaysOriginal)
        } else if let originalImage =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = originalImage.withRenderingMode(.alwaysOriginal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Enter name"
        tf.textColor = .black
        tf.addTarget(self, action: #selector(handleTapTextField(sender:)), for: .editingDidBegin)
        tf.returnKeyType = .next
        return tf
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.placeholder = "Enter email"
        tf.textColor = .black
        tf.addTarget(self, action: #selector(handleTapTextField(sender:)), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(chageEmail), for: .editingDidEnd)
        tf.returnKeyType = .done
        return tf
    }()
    
    @objc func handleTapTextField(sender: UITextField) {
        
        if sender == nameTextField {
            nameSeparatorView.backgroundColor = #colorLiteral(red: 0.007513592951, green: 0.5695900321, blue: 0.8627313972, alpha: 1)
            emailSeparatorView.backgroundColor = .lightGray
        } else if sender == emailTextField {
            nameSeparatorView.backgroundColor = .lightGray
            emailSeparatorView.backgroundColor = #colorLiteral(red: 0.007513592951, green: 0.5695900321, blue: 0.8627313972, alpha: 1)
        }
    }
    
    let nameSeparatorView = UIView()
    let emailSeparatorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        nameTextField.delegate = self
        
        navigationItem.title = "Profile Editor"
        view.backgroundColor = .white
        
        setupNavigationButtons()
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        nameSeparatorView.backgroundColor = .lightGray
        emailSeparatorView.backgroundColor = .lightGray
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            chageEmail()
            
        } else {
            emailTextField.becomeFirstResponder()
        }
        return true
    }
}

