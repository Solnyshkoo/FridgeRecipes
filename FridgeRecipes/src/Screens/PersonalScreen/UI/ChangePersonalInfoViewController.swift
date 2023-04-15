import UIKit
import CloudKit

// FIXME: - отдельный модуль
final class ChangePersonalInfoViewController: UIViewController {
    
    private let interactor: PersonalBusinessLogic
    private let factory = PersonalFactory()
    private lazy var nameTextField = factory.editTextField(text: PersonalViewController.userInfo.personalInfo.name)
    private lazy var ageTextField = factory.editTextField(text: PersonalViewController.userInfo.personalInfo.age)
    private lazy var saveButon = factory.makeButton(text: "Save")
    private lazy var cancelButon = factory.makeButton(text: "Cancel")
    
    private lazy var nametitle = factory.textLabel(text: "Your name")
    private lazy var ageTitle = factory.textLabel(text: "Your age")
    
    private lazy var genderPicker: UIPickerView = UIPickerView()
    private let dataArray = ["None", "Female", "Male"]
    private lazy var nameEror = factory.errorLabel()
    private lazy var ageEror = factory.errorLabel()
    

    private enum Constants {
        static let textLeadingOffset: CGFloat = 10
        static let textTopOffset: CGFloat = 30
        static let buttonWidth: CGFloat = (UIScreen.main.bounds.width - 40 - 15 - 10) / 2
//        static let cornerRadius: CGFloat = 15
    }
    
    init(interactor: PersonalBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        self.modalPresentationStyle = .pageSheet
        self.isModalInPresentation = false
        configUI()
    }

    func configUI() {
        view.addSubview(nameTextField)
        view.addSubview(ageTextField)
        view.addSubview(genderPicker)
        view.addSubview(cancelButon)
        view.addSubview(saveButon)
        view.addSubview(nameEror)
        view.addSubview(ageEror)
        view.addSubview(nametitle)
        view.addSubview(ageTitle)
        
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderPicker)
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPicker.selectRow(dataArray.firstIndex(
            of: PersonalViewController.userInfo.personalInfo.sex) ?? 0,
            inComponent: 0,
            animated: false
        )
        nameEror.isHidden = true
        ageEror.isHidden = true
        
        saveButon.addTarget(self, action: #selector(buttonSaveTapped), for: .touchUpInside)
        cancelButon.addTarget(self, action: #selector(buttonCancelTapped), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            nametitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 62),
            nametitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nametitle.heightAnchor.constraint(equalToConstant: 18),
            
            nameEror.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 62),
            nameEror.leadingAnchor.constraint(equalTo: nametitle.trailingAnchor, constant: 30),
            nameEror.heightAnchor.constraint(equalToConstant: 18),
            
            nameTextField.topAnchor.constraint(equalTo: nametitle.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.textLeadingOffset),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            ageTitle.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Constants.textTopOffset),
            ageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ageTitle.heightAnchor.constraint(equalToConstant: 18),

            ageEror.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Constants.textTopOffset),
            ageEror.leadingAnchor.constraint(equalTo: ageTitle.trailingAnchor, constant: 30),
            ageEror.heightAnchor.constraint(equalToConstant: 18),
            
            ageTextField.topAnchor.constraint(equalTo: ageTitle.bottomAnchor, constant: 8),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.textLeadingOffset),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ageTextField.heightAnchor.constraint(equalToConstant: 50),
            
//            nameEmpty.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 50),
//            nameEmpty.leadingAnchor.constraint(equalTo: nametitle.trailingAnchor, constant: 30),
//            nameEmpty.heightAnchor.constraint(equalToConstant: 18),
//
//            nameText.topAnchor.constraint(equalTo: nametitle.bottomAnchor, constant: 9),
//            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            nameText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            nameText.heightAnchor.constraint(equalToConstant: 50),
            
//
//            ageTitle.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 50),
//            ageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            ageTitle.heightAnchor.constraint(equalToConstant: 18),
//
//            ageEmpty.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 50),
//            ageEmpty.leadingAnchor.constraint(equalTo: ageTitle.trailingAnchor, constant: 30),
//            ageEmpty.heightAnchor.constraint(equalToConstant: 18),
//
//            ageText.topAnchor.constraint(equalTo: ageTitle.bottomAnchor, constant: 9),
//            ageText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            ageText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            ageText.heightAnchor.constraint(equalToConstant: 50),
            
            genderPicker.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: Constants.textTopOffset),
            genderPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderPicker.heightAnchor.constraint(equalToConstant: 100),
            
            saveButon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            saveButon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButon.heightAnchor.constraint(equalToConstant: 50),
            saveButon.widthAnchor.constraint(equalToConstant: Constants.buttonWidth + 10),
            
            cancelButon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            cancelButon.trailingAnchor.constraint(equalTo: saveButon.leadingAnchor, constant: -15),
            cancelButon.heightAnchor.constraint(equalToConstant: 50),
            cancelButon.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
        ])
    }
    
    @objc
    private func buttonSaveTapped(_ sender: UIButton) {
        guard
            let name = nameTextField.text,
            let age = ageTextField.text
        else {
            return
        }
        let nameErrorText = name.isEmpty ? "Empty" : ""
        var ageErrorText = age.isEmpty ? "Empty" : ""
        if ageErrorText.isEmpty {
            ageErrorText = age.isInt() ? "" : "Wrong age"
        }
        
        ageEror.isHidden = false
        nameEror.isHidden = false
        
        if nameErrorText.isEmpty && ageErrorText.isEmpty {
            PersonalViewController.userInfo.personalInfo.name = name
            PersonalViewController.userInfo.personalInfo.age = age
            PersonalViewController.userInfo.personalInfo.sex = dataArray[genderPicker.selectedRow(inComponent: 0)]
            interactor.changeValue()
        } else {
            ageEror.text = ageErrorText
            nameEror.text = nameErrorText
        }

        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func buttonCancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
    }
}

extension ChangePersonalInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let row = dataArray[row]
       return row
    }
}
extension ChangePersonalInfoViewController: ChangePersonalDisplayLogic {
}
