import CoreData
import UIKit
final class RecipeInfoWorker: RecipeInfoWorkerLogic {
    
    // MARK: - Fields

    private lazy var opQueue = FetchingOperations()
    private var fav: [CoreFav] = []
    private var cooked: [Recipe] = []
    private var rew: [CoreReward] = []
    
    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "FridgeRecipes")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Container loading failed")
            }
        }
        return container.viewContext
    }()
    
    init() {
        loadData()
    }
    
    // MARK: - Load recipe info

    func getRecipeInfo(id: String, completion: @escaping MealsCompletion) {
        let getMealById = FetchingRecipesOperation(
            type: .detailsById(id: id),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealById)
    }
//
//    func downloadImage(url: String) -> Data {
//        if let url = URL(string: url) {
//          URLSession.shared.dataTask(with: url) { (data, response, error) in
//            // Error handling...
//            guard let imageData = data else { return }
//            return imageData
//
//          }.resume()
//        }
//    }
    
    func downloadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Delete favorite recipe from Core Data

    func deleteFav(id: String) {
        let index = fav.firstIndex { item in
            item.idFav == id
        }
        
        guard let index = index else { return }
        context.delete(fav[index])
        saveChangesFav()
    }
    
    // MARK: - Delete cooked recipe from Core Data

    func deleteCooked(id: String) {
        let index = cooked.firstIndex { item in
            item.id == id
        }
        
        guard let index = index else { return }
        context.delete(cooked[index])
        saveChanges()
    }
    
    // MARK: - Save cooked recipe to Core Data

    func saveCooked(data: MainModel.Recipe.ViewModel) {
        let k = Recipe(context: context)
        k.id = data.id
        k.thumbnailLink = data.thumbnailLink ?? URL(string: "")!
        k.titleText = data.titleText ?? ""
        saveChanges()
    }
    
    // MARK: - Save favorite recipe to Core Data

    func saveFav(data: MainModel.Recipe.ViewModel) {
        let k = CoreFav(context: context)
        k.idFav = data.id
        k.linkFav = data.thumbnailLink ?? URL(string: "")!
        k.titleFav = data.titleText ?? ""
        saveChangesFav()
    }
    
    // MARK: - Save reward to Core Data

    func saveReward(data: RewardInfo.ViewModel) {
        let k = CoreReward(context: context)
        k.title = data.rewardText
        k.imgString = data.rewardImage
        saveChangesRew()
    }
    
    // MARK: - Update cooked recipe in Core Data

    private func saveChanges() {
        if context.hasChanges {
            try? context.save()
        }
        if let note = try? context.fetch(Recipe.fetchRequest()) {
            cooked = note
            PersonalViewController.userInfo.cookedRecipes = parse(note)
        } else {
            cooked = []
            PersonalViewController.userInfo.cookedRecipes = []
        }
    }
    
    // MARK: - Update favorite recipe in Core Data

    private func saveChangesFav() {
        if context.hasChanges {
            try? context.save()
        }
        if let note = try? context.fetch(CoreFav.fetchRequest()) {
            fav = note
            PersonalViewController.userInfo.favoriteRecipes = parse(note)
        } else {
            fav = []
            PersonalViewController.userInfo.favoriteRecipes = []
        }
    }
    
    // MARK: - Update rewards in Core Data

    private func saveChangesRew() {
        if context.hasChanges {
            try? context.save()
        }
        if let note = try? context.fetch(CoreReward.fetchRequest()) {
            PersonalViewController.userInfo.rewards = parse(note)
            rew = note
        } else {
            rew = []
            PersonalViewController.userInfo.rewards = []
        }
    }
    
    // MARK: - Load recipes from Core Data

    private func loadData() {
        if let notes = try? context.fetch(Recipe.fetchRequest()) {
            cooked = notes
        } else {
            cooked = []
        }
        
        if let favt = try? context.fetch(CoreFav.fetchRequest()) {
            fav = favt
        } else {
            fav = []
        }
        
        if let rewards = try? context.fetch(CoreReward.fetchRequest()) {
            rew = rewards
        } else {
            rew = []
        }
    }
    
    // MARK: - Parse data

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
}
