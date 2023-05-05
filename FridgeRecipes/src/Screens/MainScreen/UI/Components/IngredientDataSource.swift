import UIKit

final class IngredientDataSource: NSObject, UICollectionViewDataSource {
    private enum Constants {
        static let edgeInsetValue: CGFloat = 10
    }

    private let cellID: String

    private let keys: [String]
    private let updateParentFilters: (String) -> Void

    private(set) var filters: String = ""
    private(set) var previousIndex: IndexPath = .init(row: 0, section: 0)

    init(cellID: String, updateParentFilters: @escaping (String) -> Void) {
        self.cellID = cellID
        self.keys = Array(ingredientSuggestions.keys)
        self.updateParentFilters = updateParentFilters
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        min(keys.count, 20)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        guard let ingredientCell = cell as? IngredientSuggestionCell else { return cell }
        guard let ingredient = ingredientSuggestions[keys[indexPath.row]] else { return cell }
        ingredientCell.config(name: ingredient.fullName)
        ingredientCell.isUserInteractionEnabled = true
        return ingredientCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ingredient = keys[indexPath.row]
        if filters == ingredient {
            filters = ""
        } else {
            filters = ingredient
        }
        DispatchQueue.main.async {
            collectionView.reloadItems(at: [self.previousIndex, indexPath])
            self.updateParentFilters(self.filters)
            self.previousIndex = indexPath
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout delegate
extension IngredientDataSource: UICollectionViewDelegateFlowLayout {
    private func getCellTextWidth(_ s: String?) -> CGFloat {
        guard let s = s else { return 0 }
        let font = IngredientSuggestionCell.titleFont
        let attributes = [NSAttributedString.Key.font: font]
        let size = NSString(string: s).size(withAttributes: attributes)
        return size.width
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = getCellTextWidth(ingredientSuggestions[keys[indexPath.row]]?.fullName) +
            Constants.edgeInsetValue * 2
        return CGSize(width: width, height: collectionView.bounds.height)
    }
}
