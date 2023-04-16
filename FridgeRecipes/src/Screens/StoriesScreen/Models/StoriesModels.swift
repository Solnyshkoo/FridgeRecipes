import UIKit

enum StoriesModels {
    // MARK: Use cases
    struct Request {
    
    }
    
    struct Response: Decodable {
    }
    
    struct ViewModel {
        let storiesString: [String]
    }
   
}
