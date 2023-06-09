import UIKit

final class PersonalRouter: PersonalRoutingLogic {
    // MARK: - Fields

    weak var view: UIViewController?
   
    // MARK: - Open edit personal info screen

    func routeToChangePersonalInfoScreen(interactor: PersonalBusinessLogic) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let vc = ChangePersonalInfoViewController(interactor: interactor)
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.largestUndimmedDetentIdentifier = .none
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersGrabberVisible = true
            }
            
            self.view?.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Open rewards screen

    func routeToRewards(interactor: PersonalBusinessLogic) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let vc = RewardViewController(
                interactor: interactor
            )
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = true
                sheet.prefersGrabberVisible = true
            }
            
            self.view?.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Open nutrition screen

    func routeToNutritionScreen(data: [String]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let vc = NutritionAssembly.build(data: data)
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = true
                sheet.prefersGrabberVisible = true
            }
            
            self.view?.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Open cooked recipes screen

    func routeToCookedRecipesScreen(data: [MainModel.Recipe.ViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.navigationController?.pushViewController(PersonalRecipesAssembly.build(data: data, title: "Your cookbook"), animated: true)
        }
    }
    
    // MARK: - Open favorite recipes screen

    func routeToFavoriteRecilesScreen(data: [MainModel.Recipe.ViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.navigationController?.pushViewController(PersonalRecipesAssembly.build(data: data, title: "Favorite"), animated: true)
        }
    }
}
