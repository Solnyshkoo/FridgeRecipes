import UIKit

enum UserInfo {
    struct Request
    {}

    struct Response
    {}

    struct ViewModel {
        var personalInfo: RegistrationInfo.ViewModel
        var cookedRecipes: [MainModel.Recipe.ViewModel]
        var favoriteRecipes: [MainModel.Recipe.ViewModel]
        var rewards: [RewardInfo.ViewModel]
        
        init() {
            self.personalInfo = RegistrationInfo.ViewModel(name: "", age: "", sex: "")
            self.cookedRecipes = []
            self.favoriteRecipes = []
            self.rewards = []
        }
        
        init(personalInfo: RegistrationInfo.ViewModel) {
            self.personalInfo = personalInfo
            self.cookedRecipes = []
            self.favoriteRecipes = []
            self.rewards = []
        }
    }
}
