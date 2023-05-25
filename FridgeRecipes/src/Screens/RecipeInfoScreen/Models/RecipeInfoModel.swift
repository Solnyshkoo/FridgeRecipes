import UIKit

enum RecipeInfoModel {
    enum Start {
        struct Request {
            let id: String
        }

        struct Response: Decodable {
            enum CodingKeys: String, CodingKey {
                case meals
            }

            var meals: [RecipeInfo]
        }

        struct ViewModel {}
    }
}
