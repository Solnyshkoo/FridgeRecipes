import Foundation

enum RequestType {
    case detailsById(id: String)
    case randomMeals
    case ingredientsList
    case mealsByIngredient(ingredient: String)
    case mealsByName(name: String)
    case nutritionInfo(text: String)
    
    private var params: [String: String] {
        switch self {
        case let .detailsById(id):
            return ["i": id]
        case .randomMeals:
            return [:]
        case .ingredientsList:
            return ["i": "list"]
        case let .mealsByIngredient(ingredient: ingredient):
            return ["i": ingredient]
        case let .mealsByName(name: name):
            return ["s": name]
        case let .nutritionInfo(text: text):
            return ["app_id" : NetworkInfo.app_id,
                    "app_key" : NetworkInfo.app_key,
                    "nutrition-type" : "cooking",
                    "ingr" : text]
        }
    }

    var url: URL? {
        makeUrl(params: params)
    }

    private var path: String {
        switch self {
        case .detailsById:
            return "lookup"
        case .randomMeals:
            return "randomselection"
        case .ingredientsList:
            return "list"
        case .mealsByIngredient:
            return "filter"
        case .mealsByName:
            return "search"
        case .nutritionInfo:
            return ""
        }
    }

    private func makeUrl(params: [String: String]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        
        switch self {
        case .nutritionInfo:
            urlComponents.host = NetworkInfo.nutritionHost
            urlComponents.path = "/api/nutrition-data"
        default:
            urlComponents.host = NetworkInfo.mealHost
            urlComponents.path = "/api/json/v2/\(NetworkInfo.apiKey)/\(path).php"
        }
        
        urlComponents.host = NetworkInfo.mealHost
        urlComponents.path = "/api/json/v2/\(NetworkInfo.apiKey)/\(path).php"

        var queryItems: [URLQueryItem] = []

        for (paramName, paramValue) in params {
            queryItems.append(URLQueryItem(name: paramName, value: paramValue))
        }

        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}

fileprivate enum NetworkInfo {
    static let mealHost: String = "www.themealdb.com"
    static let apiKey: Int = 1
    
    static let nutritionHost: String = "api.edamam.com"
    static let app_id: String = "96ee078b"
    static let app_key: String = "e3520d3059623ef422c7a259abb9025e"
}
