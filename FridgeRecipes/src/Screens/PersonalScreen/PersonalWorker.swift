import CoreData
import Foundation
final class PersonalWorker: PersonalWorkerLogic {
    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "FridgeRecipes")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Container loading failed")
            }
        }
        return container.viewContext
    }()
    
    func getUserInfo() {
        loadData()
    }

    private func loadData() {
        if let notes = try? context.fetch(Recipe.fetchRequest()) {
            PersonalViewController.userInfo.cookedRecipes = parse(notes)
        } else {
            PersonalViewController.userInfo.cookedRecipes = []
        }
        
        if let fav = try? context.fetch(CoreFav.fetchRequest()) {
            PersonalViewController.userInfo.favoriteRecipes = parse(fav)!
        } else {
            PersonalViewController.userInfo.favoriteRecipes = []
        }
        
        if let rewards = try? context.fetch(CoreReward.fetchRequest()) {
            PersonalViewController.userInfo.rewards = parse(rewards) 
        } else {
            PersonalViewController.userInfo.rewards = []
        }
    }
    
    private func parse(_ notes: [CoreReward]) -> [RewardInfo.ViewModel] {
        var k: [RewardInfo.ViewModel] = []
        notes.forEach { item in
            k.append(RewardInfo.ViewModel(rewardText: item.title, rewardImage: item.imgString))
        }
        return k
    }

    private func parse(_ notes: [CoreFav]) -> [MainModel.Recipe.ViewModel] {
        var k: [MainModel.Recipe.ViewModel] = []
        notes.forEach { item in
            k.append(MainModel.Recipe.ViewModel(id: item.idFav, titleText: item.titleFav, thumbnailLink: item.linkFav))
        }
        return k
    }
    
    private func parse(_ notes: [Recipe]) -> [MainModel.Recipe.ViewModel] {
        var k: [MainModel.Recipe.ViewModel] = []
        notes.forEach { item in
            k.append(MainModel.Recipe.ViewModel(id: item.id, titleText: item.titleText, thumbnailLink: item.thumbnailLink))
        }
        return k
    }
    
    func saveUserInfo() {
        let defaults = UserDefaults.standard
        defaults.set(PersonalViewController.userInfo.personalInfo.name, forKey: "name")
        defaults.set(PersonalViewController.userInfo.personalInfo.age, forKey: "age")
        defaults.set(PersonalViewController.userInfo.personalInfo.sex, forKey: "gender")
    }
}
