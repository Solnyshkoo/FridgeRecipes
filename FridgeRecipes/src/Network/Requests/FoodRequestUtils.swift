import Foundation

enum RequestType {
    case detailsById(id: String)
    case randomMeals
    case ingredientsList
    case mealsByIngredient(ingredient: String)
    case mealsByName(name: String)
    
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
        }
    }

    private func makeUrl(params: [String: String]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
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
}
