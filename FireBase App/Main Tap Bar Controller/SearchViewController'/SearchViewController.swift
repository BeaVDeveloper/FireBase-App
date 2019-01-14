//
//  SearchViewController.swift
//  testApp
//
//  Created by Yura Velko on 12/24/18.
//  Copyright © 2018 Yura Velko. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter username"
        sb.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        return sb
    }()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceVertical = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }
}
