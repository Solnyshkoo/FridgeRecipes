import Foundation
final class PersonalWorker: PersonalWorkerLogic {

    
    // FIXME: - загрузка из Core Data
    func getUserInfo()  {
        
    }
    
    func saveUserInfo() {
        let defaults = UserDefaults.standard
        defaults.set(PersonalViewController.userInfo.personalInfo.name, forKey: "name")
        defaults.set(PersonalViewController.userInfo.personalInfo.age, forKey: "age")
        defaults.set(PersonalViewController.userInfo.personalInfo.sex, forKey: "gender")
    }
}
