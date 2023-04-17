import CoreData
final class RecipeInfoWorker: RecipeInfoWorkerLogic {
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
     
    func deleteFav(id: String) {
        let index = fav.firstIndex { item in
            item.idFav == id
        }
        
        guard let index = index else { return }
        context.delete(fav[index])
        saveChangesFav()
    }
    
    func deleteCooked(id: String) {
        let index = cooked.firstIndex { item in
            item.id == id
        }
        
        guard let index = index else { return }
        context.delete(cooked[index])
        saveChanges()
    }
    
    func getRecipeInfo(id: String, completion: @escaping MealsCompletion) {
        let getMealById = FetchingRecipesOperation(
            type: .detailsById(id: id),
            completion: completion
        )
        opQueue.fetchingQueue.addOperation(getMealById)
    }
    
    func save(data: MainModel.Recipe.ViewModel) {
        let k = Recipe(context: context)
        k.id = data.id
        k.thumbnailLink = data.thumbnailLink ?? URL(string: "")!
        k.titleText = data.titleText ?? ""
        saveChanges()
    }
    
    func saveFav(data: MainModel.Recipe.ViewModel) {
        let k = CoreFav(context: context)
        k.idFav = data.id
        k.linkFav = data.thumbnailLink ?? URL(string: "")!
        k.titleFav = data.titleText ?? ""
        saveChangesFav()
    }
    
    func saveReward(data: RewardInfo.ViewModel) {
        let k = CoreReward(context: context)
        k.title = data.rewardText
        k.imgString = data.rewardImage
        saveChangesRew()
    }
    
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
