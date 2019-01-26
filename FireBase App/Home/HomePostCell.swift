//
//  HomePostCell.swift
//  FireBase App
//
//  Created by Yura Velko on 1/3/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit


protocol HomePostCellDelegate {
    func didTapComment(post: Post)
    func didLike(for cell: HomePostCell)
}

protocol TapOnNameDelegate {
    func didTapOnName(uid: String)
}


class HomePostCell: UICollectionViewCell {
    
    var homeDelegate: HomePostCellDelegate?
    var nameTapDelegate: TapOnNameDelegate?
    
    var post: Post? {
        didSet {
            guard let postImageUrl = post?.imageUrl else { return }
            guard let profileImageUrl = post?.user.profileImageUrl else { return }
            
            likeButton.setImage(post?.hasLiked == true ? #imageLiteral(resourceName: "icons8-heart-outline-filled-100").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "icons8-heart-outline-100").withRenderingMode(.alwaysOriginal) , for: .normal)
            
            photoImageView.loadImage(urlString: postImageUrl)
            userProfileImageView.loadImage(urlString: profileImageUrl)
            
            usernameLabel.text = post?.user.username
            
            setupAttributedCaption()
        }
    }
    
    private func setupAttributedCaption() {
        guard let post = post else { return }
        
        let attributedText = NSMutableAttributedString(string: post.user.username, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string:" \(post.caption)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        
        let timeAgoDisplay = post.creationDate.timeAgoDisplay()
        attributedText.append(NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        captionLabel.attributedText = attributedText
    }
    
    let userProfileImageView = CustomImageView(frame: .zero)
    let photoImageView = CustomImageView(frame: .zero)
    
    let usernameLabel = CustomAttributedLabel(tLine: nil, bLine: nil, color: nil)
    let captionLabel = CustomAttributedLabel(tLine: nil, bLine: nil, color: nil)
    
    let optionsButton = CustomHeaderButton(image: nil, title: "•••")
    let likeButton = CustomHeaderButton(image: #imageLiteral(resourceName: "icons8-heart-outline-100"), title: nil)
    let commentButton = CustomHeaderButton(image: #imageLiteral(resourceName: "comment"), title: nil)
    let bookmarkButton = CustomHeaderButton(image: #imageLiteral(resourceName: "ribbon"), title: nil)
    let sendMessageButton = CustomHeaderButton(image: #imageLiteral(resourceName: "send2"), title: nil)
    
    
    func setupTargets() {
        usernameLabel.isUserInteractionEnabled = true
        commentButton.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        usernameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleName)))
        userProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleName)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTargets()
        
        addSubview(userProfileImageView)
        addSubview(usernameLabel)
        addSubview(optionsButton)
        addSubview(photoImageView)
        
        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        userProfileImageView.layer.cornerRadius = 40/2
        
        usernameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: photoImageView.topAnchor, right: optionsButton.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        optionsButton.anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
        
        photoImageView.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        setupActionButtons()
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
    }
    
    private func setupActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sendMessageButton])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
        
        addSubview(bookmarkButton)
        bookmarkButton.anchor(top: photoImageView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 50)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
