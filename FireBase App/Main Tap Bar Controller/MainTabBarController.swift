//
//  MainTabBarController.swift
//  testApp
//
//  Created by Yura Velko on 12/24/18.
//  Copyright © 2018 Yura Velko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = AddPostViewController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            
            present(navController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LogInViewController()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController, animated: true, completion: nil)
            }
        }
        setUpNavControllers()
     
    }
    
    private func setUpNavControllers() {
        
        //home
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "icons8-home-100"), selectedImage: #imageLiteral(resourceName: "icons8-home-filled-100"), rootViewController: HomeViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //search
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "icons8-search-100"), selectedImage: #imageLiteral(resourceName: "icons8-search-filled-100"), rootViewController: SearchViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //new post
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "icons8-plus-100"), selectedImage: #imageLiteral(resourceName: "icons8-plus-100"))
        
        //like vc
        let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "icons8-heart-outline-100"), selectedImage: #imageLiteral(resourceName: "icons8-heart-outline-filled-100"), rootViewController: FavoritesViewController())
        
        //user profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = ProfileViewController(collectionViewLayout: layout)
        
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "icons8-contacts-100")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "icons8-contacts-filled-100 ")
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController,
                           searchNavController,
                           plusNavController,
                           likeNavController,
                           userProfileNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
