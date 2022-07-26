//
//  ShadesCollectionViewCell.swift
//  StickWith
//
//  Created by Adarsh Pandey on 23/07/22.
//

import UIKit

class ShadesCollectionViewCell: UICollectionViewCell {

    @IBOutlet var shade: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shade.layer.masksToBounds = true
        shade.layer.cornerRadius = shade.bounds.width / 2
    }

}
