import Foundation

struct BrandModel: Codable {

    let name: String
    let price: String
    let imageLink: URL
    let websiteLink: URL
    let welcomeDescription: String
    let rating: Double?
    let productType: String
    let productApiURL: URL
    let productColours: [ProductColours]

    

    enum CodingKeys: String, CodingKey {
        case name
        case price
        case imageLink = "image_link"
        case websiteLink = "website_link"
        case welcomeDescription = "description"
        case rating
        case productType = "product_type"
        case productApiURL = "product_api_url"
        case productColours = "product_colors"
    }
}

struct ProductColours: Codable {
    let hexValue: String?

    enum CodingKeys: String, CodingKey {
        case hexValue = "hex_value"
    }
}
