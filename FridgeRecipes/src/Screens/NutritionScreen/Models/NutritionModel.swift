import UIKit

enum NutritionModel {
    // MARK: Use cases
    enum Start {
        struct Request {
            let text: String
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
