import Foundation
import UIKit
final class RegistrationFactory {
    
    private enum Constants {
        static let titleFontSize: CGFloat = 40
        static let textFontSize: CGFloat = 18
        static let cornerRadius: CGFloat = 15
    }
    
    func titleLabel() -> UILabel {
        let titleText = UILabel()
        titleText.text = "Fridge Recipes"
        titleText.numberOfLines = 0
        titleText.lineBreakMode = .byWordWrapping
        titleText.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        titleText.translatesAutoresizingMaskIntoConstraints = false
        return titleText
    }
    
    func textLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: Constants.textFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func errorLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemRed
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: Constants.textFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func registrationTextField() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "Type here"
        textField.backgroundColor = UIColor.secondarySystemBackground
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.setLeftPaddingPoints(15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    func registrationButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Constants.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
}
