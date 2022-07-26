//
//  SecondScreenController.swift
//  StickWith
//
//  Created by Adarsh Pandey on 22/07/22.
//

import UIKit

class SecondScreenController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var titleLabel: String?
    var priceLabel: String?
    var productTypeLabel: String?
    var descriptionLabel: String?
    var urlLabel: URL?
    var rating: Double?
    var shades: [ProductColours]?
    
    let kCellIdentifier = "ShadesCollectionView"
    let interItemSpacing: CGFloat = 16.0
    let lineSpacing: CGFloat = 16.0
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var productTitle: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var productType: UILabel!
    @IBOutlet var productDescription: UILabel!
    @IBOutlet var productRating: UILabel!
    @IBOutlet var shadesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCustomViewInCell()
        productTitle.font = UIFont.boldSystemFont(ofSize: 22.0)
        productType.font = UIFont.italicSystemFont(ofSize: 15.0)
        shadesCollection.delegate = self
        shadesCollection.dataSource = self
        
        price.textColor = .red
        
        updateLabels()
    }
    
    func registerCustomViewInCell() {
        let nib = UINib(nibName: "ShadesCollectionViewCell", bundle: nil)
        shadesCollection.register(nib, forCellWithReuseIdentifier: "ShadesCollectionView")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let val = shades?.count {
            return val
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as? ShadesCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let color = shades?[indexPath.row].hexValue {
            cell.shade.backgroundColor = UIColor(hexaString: color)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 300.0 , height: collectionView.bounds.width - 10.0)
    }
    
    func updateLabels() {
        if let val = titleLabel {
            productTitle.text = val
        } else {
            print("titleLabel is nil")
        }
        
        if let val = priceLabel {
            price.text = "$\(val)"
        } else {
            print("priceLabel is nil")
        }
        
        if let val = productTypeLabel {
            productType.text = val
        } else {
            print("productTypeLabel is nil")
        }
        
        if let val = descriptionLabel {
            productDescription.text = val
        } else {
            print("descriptionLabel is nil")
        }
        
        if let url = urlLabel {
            imageView.load(url: url)
        } else {
            print("urlLabel is nil")
        }
        
        if let val = rating {
            let roundedOffRating = floor(val)
            
            if roundedOffRating == 1.0 {
                productRating.text = "★"
            } else if roundedOffRating == 2.0 {
                productRating.text = "★★"
            } else if roundedOffRating == 3.0 {
                productRating.text = "★★★"
            } else if roundedOffRating == 4.0 {
                productRating.text = "★★★★"
            } else {
                productRating.text = "★★★★★"
            }
            
        } else {
            productRating.font = UIFont.italicSystemFont(ofSize: 15.0)
            productRating.text = "No Rating"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
