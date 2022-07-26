//
//  ProductTableViewController.swift
//  StickWith
//
//  Created by Adarsh Pandey on 22/07/22.
//

import UIKit

class ProductTableViewController: UITableViewController, BrandManagerDelegate {
    
    var brandData: [BrandModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updatedData(brand: [BrandModel]) {
        brandData = brand
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return brandData.count
    }
}
