import UIKit

final class MainRouter: MainRoutingLogic {
    weak var view: UIViewController?

    // MARK: - Open Recipe screen

    func routeToRecipesScreen(data: RequestType, titleText: String) {
        let viewController = RecipesAssembly.build(data: data, titleText: titleText)
        view?.navigationController?.pushViewController(viewController, animated: false)
    }

    // MARK: - Open Stories

    func routeToStories() {
        let vc = StoriesViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersGrabberVisible = true
        }
        self.view?.present(vc, animated: false, completion: nil)
    }
}
