//
//  gamecell.swift
//  TicTacToe
//
//  Created by Sandhya Baghel on 04/07/21.
//  Copyright © 2021 Sandhya. All rights reserved.
//

import Foundation


import UIKit

class gamecell: UICollectionViewCell {
    
    private let myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setupCell(with status:Int) {
        
        contentView.layer.borderWidth = 2
       // contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(myImageView)
        
        myImageView.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        
        let name = status == 0 ? "circle" : status == 1 ? "multiply" : ""
        
        myImageView.image = UIImage(systemName: name)
    }
    
}
