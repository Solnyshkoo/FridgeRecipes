import UIKit

enum StoriesModels {
    struct Request {}
    
    struct Response: Decodable {}
    
    struct ViewModel {
        let storiesString: [String]
    }
}
