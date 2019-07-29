//
//  PuzzleCell.swift
//  NpuzzleApp
//
//  Created by Leo-taro FUJIMOTO on 7/29/19.
//  Copyright © 2019 Leo-taro FUJIMOTO. All rights reserved.
//

import UIKit

class PuzzleCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    var myValue : (name: String, value: Int, size: Int)? {
        didSet {
            image.image = UIImage(named: "\(myValue!.name)_\(String(describing: myValue!.size))_\(String(describing: myValue!.value))")
            if myValue!.value == 0 {
                image.isHighlighted = true
                image.tintColor = .green
                image.alpha = 0.35
            }
        }
    }
}
