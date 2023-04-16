import UIKit
final class PersonalFactory {
    
    private enum Constants {
        static let textFontSize: CGFloat = 17
        static let cornerRadius: CGFloat = 15
    }
    
    func editTextField(text: String) -> UITextField {
        let textField = UITextField()
        textField.text = text
        textField.backgroundColor = UIColor.secondarySystemBackground
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.setLeftPaddingPoints(15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    func textLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
//        label.textColor = .systemGray
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: Constants.textFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeButton(text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.backgroundColor = (text == "Save" ? UIColor.systemBlue : UIColor.secondarySystemBackground)
        button.layer.cornerRadius = Constants.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
}
