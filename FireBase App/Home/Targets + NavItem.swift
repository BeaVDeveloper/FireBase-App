//
//  Targets + NavItem.swift
//  FireBase App
//
//  Created by Yura Velko on 1/18/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit


extension HomeViewController {
    
    
    func setupSwipeGesture() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(handleCamera))
        left.direction = .right
        view.addGestureRecognizer(left)
    }
    
    @objc func handleUpdateFeed() {
        handleRefresh()
    }
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchAllPosts()
    }
    
    func setupNavigationItems() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera3").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCamera))
    }
    
    @objc func handleCamera() {
        let cameraController = CameraController()
        present(cameraController, animated: true, completion: nil)
    }
}

extension HomePostCell {
    
    @objc func handleComment() {
        guard let post = post else { return }
        delegate?.didTapComment(post: post)
    }
}
