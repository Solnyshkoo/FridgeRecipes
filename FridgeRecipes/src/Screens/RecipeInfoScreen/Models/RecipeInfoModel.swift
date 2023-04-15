import UIKit

enum RecipeInfoModel {
    // MARK: Use cases
    enum Start {
        struct Request {
            let id: String
        }
        
        struct Response: Decodable{
            enum CodingKeys: String, CodingKey {
                case meals
            }

            let meals: [RecipeInfo]
        }
        
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
}
