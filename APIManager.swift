//
//  APIManager.swift
//  StickWith
//
//  Created by Adarsh Pandey on 22/07/22.
//

import Foundation

protocol BrandManagerDelegate: AnyObject {
    func updatedData(brand: [BrandModel])
}

class APIManager {
    
    let apiURL = "https://makeup-api.herokuapp.com/api/v1/products.json?brand="
    
    weak var delegate: BrandManagerDelegate?
    
    func fecthBrandDetails(brandName: String) {
        let urlString = "\(apiURL)\(brandName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                if error != nil {
                    print("Error!")
                    return
                }
                
                if let safeData = data {
                    if let brand = self?.parseJSON(safeData) {
                        self?.delegate?.updatedData(brand: brand)
                    }
                }
            }
            task.resume()
        } else {
            print("\(urlString) is invalid")
        }
    }
    
    func parseJSON(_ brandData: Data) -> [BrandModel]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([BrandModel].self, from: brandData)
            return decodeData
        } catch {
            print("Error")
            return nil
        }
    }
}

