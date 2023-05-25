import UIKit

enum MainModel {
    enum Recipe {
        struct Request {
            let searchText: String
            let productsFilter: [String]
        }

        struct Response: Decodable {
            enum CodingKeys: String, CodingKey {
                case meals
            }

            var meals: [RecipeInfo]
        }

        struct ViewModel {
            let id: String
            let titleText: String?
            let thumbnailLink: URL?
        }
    }
}
