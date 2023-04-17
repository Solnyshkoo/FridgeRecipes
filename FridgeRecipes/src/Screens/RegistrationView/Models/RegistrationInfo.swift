
import Foundation
enum RegistrationInfo {
    struct Request {
        let name: String
        let age: String
        let sex: String
    }

    struct Response {
        let nameError: String?
        let ageError: String?
    }

    struct ViewModel {
        var name: String
        var age: String
        var sex: String
        var level: String

        init(name: String, age: String, sex: String, level: String = "1") {
            self.name = name
            self.age = age
            self.sex = sex
            self.level = level
        }
    }
}
