import UIKit

enum MainModel {
    // MARK: Use cases
    enum Start {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    
    enum Action {
        struct Request
        {}

        struct Response
        {}

        struct ViewModel
        {}
    }
    
    enum Recipe {
        struct Request {
            let searchText: String
            let productsFilter: [String]
        }
        
        struct Response: Decodable{
            enum CodingKeys: String, CodingKey {
                case meals
            }

            let meals: [RecipeInfo]
        }
        
        struct ViewModel {
            let id: String
            let titleText: String?
            let thumbnailLink: URL?
        }
    
    }
}
