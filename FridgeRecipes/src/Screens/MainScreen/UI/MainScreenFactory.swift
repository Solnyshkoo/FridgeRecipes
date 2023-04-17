import CloudKit
import UIKit

final class MainScreenFactory {
    private enum Constants {
        static let searchBarPlaceHolder = "Meal, ingredient..."
        static let sideInsetValue: CGFloat = 16
        static let sideInsets = UIEdgeInsets(
            top: 0,
            left: sideInsetValue,
            bottom: 0,
            right: sideInsetValue
        )
        
        static let titleSpacing: CGFloat = 5
        static let titleFontSize: CGFloat = 17
        static let ingredientSuggestTitle = "Search by ingredient"
        static let sectionSpacing: CGFloat = 10
    }
    
    func makeSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.layoutMargins = Constants.sideInsets
        searchBar.placeholder = Constants.searchBarPlaceHolder
        return searchBar
    }
    
    func makeResultCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = Constants.sideInsets
        cv.showsHorizontalScrollIndicator = false
        return cv
    }
    
    func makeScrollView() -> UIScrollView {
        UIScrollView()
    }
    
    func makeStoriesStackView() -> UIView {
        StoriesStackView()
    }
    
    func makeCategoryStackView() -> CategoryStackView {
        CategoryStackView()
    }
    
    func makeCusineStackView() -> CusineStackView {
        CusineStackView()
    }
    
    func makeIngredientCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = Constants.sideInsets
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }
    
    func makeIngredientSuggestionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Constants.titleSpacing
        return stackView
    }

    func makeIngredientSuggestionTitle() -> UILabel {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        title.text = Constants.ingredientSuggestTitle
        title.textAlignment = .left
        return title
    }
    
    func makeSuggestionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = Constants.sectionSpacing
        return stackView
    }
}
