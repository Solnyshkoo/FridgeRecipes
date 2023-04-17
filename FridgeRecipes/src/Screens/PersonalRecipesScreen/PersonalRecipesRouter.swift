import UIKit

final class PersonalRecipesRouter: PersonalRecipesRoutingLogic {
    weak var view: UIViewController?

    func routeToRecipeInfoScreen(data: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.navigationController?.pushViewController(RecipeInfoAssembly.build(data: data), animated: true)
        }
    }
}
