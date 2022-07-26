//
//  ProductTableViewCell.swift
//  StickWith
//
//  Created by Adarsh Pandey on 23/07/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    

    @IBOutlet var title: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productType: UILabel!
    @IBOutlet var price: UILabel!
    
    @IBOutlet var firstColor: UILabel!
    @IBOutlet var secondColor: UILabel!
    @IBOutlet var thirdColor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        firstColor.layer.masksToBounds = true
        firstColor.layer.cornerRadius = 10
        
        secondColor.layer.masksToBounds = true
        secondColor.layer.cornerRadius = 10
        
        thirdColor.layer.masksToBounds = true
        thirdColor.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
