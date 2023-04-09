import UIKit

enum NetworkError: Error {
    case unableToMakeURL
    case noResponseData
    case parsingError
    case serverError(error: Error)
}
