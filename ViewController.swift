//
//  ViewController.swift
//  StickWith
//
//  Created by Adarsh Pandey on 22/07/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, BrandManagerDelegate {
    
    let apiManager = APIManager()
    var brandData: [BrandModel]?
    let kCellIndentifier = "ProductTableViewCell"
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var searchField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCustomViewInCell()
        self.title = "StickWith"
        searchField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        apiManager.delegate = self
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.hidesWhenStopped = true
        
    }
    
    func registerCustomViewInCell() {
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    func updatedData(brand: [BrandModel]) {
        brandData = brand
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func searchButton(_ sender: Any) {
        if let val = searchField.text {
            activityIndicator.startAnimating()
            apiManager.fecthBrandDetails(brandName: val)
        } else {
            print("searchField.text is nil")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let secondScreenController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondScreenController") as? SecondScreenController {

            secondScreenController.titleLabel = brandData?[indexPath.row].name
            secondScreenController.priceLabel = brandData?[indexPath.row].price
            secondScreenController.productTypeLabel = brandData?[indexPath.row].productType
            secondScreenController.descriptionLabel = brandData?[indexPath.row].welcomeDescription
            secondScreenController.urlLabel = brandData?[indexPath.row].imageLink
            secondScreenController.rating = brandData?[indexPath.row].rating
            secondScreenController.shades = brandData?[indexPath.row].productColours
            navigationController?.pushViewController(secondScreenController, animated: true)
        } else {
            print("Error getitng detail view controller")
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.brandData {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIndentifier, for: indexPath) as? ProductTableViewCell else {
            print("Failed to create the custom cell")
            return UITableViewCell()
        }

        cell.title.text = brandData?[indexPath.row].name
        cell.productType.text = brandData?[indexPath.row].productType
        
        if let price = brandData?[indexPath.row].price {
            cell.price.text = "$\(price)"
        }
        
        if let urlLink = brandData?[indexPath.row].imageLink {
            cell.productImage.load(url: urlLink)
        }
        
        if let numberOfColors = brandData?[indexPath.row].productColours.count {
            if let arrayOfColors = brandData?[indexPath.row].productColours {
                if(numberOfColors == 0 || numberOfColors == 1) {
                    cell.firstColor.text = ""
                    cell.secondColor.text = ""
                    cell.thirdColor.text = ""
                    
                } else if (numberOfColors == 2) {
                    if let firstColor = arrayOfColors[0].hexValue , let secondColor = arrayOfColors[1].hexValue {
                        cell.firstColor.text = ""
                        cell.secondColor.text = ""
                        cell.thirdColor.text = ""
                        
                        cell.firstColor.backgroundColor = UIColor(hexaString: firstColor)
                        cell.secondColor.backgroundColor = UIColor(hexaString: secondColor)
                    } else {
                        print("Color/s nil")
                    }
                } else {
                    if let firstColor = arrayOfColors[0].hexValue , let secondColor = arrayOfColors[1].hexValue {
                        cell.firstColor.text = ""
                        cell.secondColor.text = ""
                        cell.thirdColor.text = "+" + String (numberOfColors - 2)
                        cell.firstColor.backgroundColor = UIColor(hexaString: firstColor)
                        cell.secondColor.backgroundColor = UIColor(hexaString: secondColor)
                        
                        cell.thirdColor.layer.borderWidth = 1.0
                        
                    } else {
                        print("Color/s nil")
                    }
                }
            }
        } else {
            print("Colors not present")
        }
        return cell
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIColor {
    convenience init(hexaString: String, alpha: CGFloat = 1) {
        let chars = Array(hexaString.dropFirst())

        self.init(red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
                  green: .init(strtoul(String(chars[2...3]),nil,16))/255,
                  blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
                  alpha: alpha)}
}
