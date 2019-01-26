//
//  CustomProfileLabel.swift
//  FireBase App
//
//  Created by Yura Velko on 1/23/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit

class CustomAttributedLabel: UILabel {
    let tLine: String?
    let bLine: String?
    let color: UIColor?
    
    init(tLine: String?, bLine: String?, color: UIColor?) {
        self.tLine = tLine
        self.bLine = bLine
        self.color = color
        
        super.init(frame: .zero)
        
        numberOfLines = 0
        if tLine != nil && bLine != nil {
            let attributedText = NSMutableAttributedString(string: tLine! + "\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: bLine!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
            self.attributedText = attributedText
            textAlignment = .center
            return
        }
        isUserInteractionEnabled = true
        textColor = color ?? .black
        text = tLine
        font = UIFont.boldSystemFont(ofSize: 14)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CustomHeaderButton: UIButton {
    
    let image: UIImage?
    let title: String?
    
    init(image: UIImage?, title: String?) {
        self.image = image
        self.title = title
        
        super.init(frame: .zero)
        setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        setTitle(title, for: .normal)
        if title != nil {
            setTitleColor(.black, for: .normal)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CustomTextField: UITextField {
    
    let txt: String
    let keyType: UIReturnKeyType
    
    init(txt: String, keyType: UIReturnKeyType) {
        self.txt = txt
        self.keyType = keyType
        
        super.init(frame: .zero)
        
        placeholder = txt
        returnKeyType = keyType
        font = UIFont.systemFont(ofSize: 16)
        textColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentMode = .scaleAspectFill
        clipsToBounds = true
        isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedToLoadImage = urlString
        
        self.image = nil
        
        if let cacheImage = imageCache[urlString] {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fecth post image: ", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
    }
}
