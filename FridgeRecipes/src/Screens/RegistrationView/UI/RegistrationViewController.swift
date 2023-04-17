import UIKit

final class RegistrationViewController: UIViewController {
    private let router: RegistrationRoutingLogic
    private let interactor: RegistrationBusinessLogic
    private let factory = RegistrationFactory()
    
    private lazy var titleText = factory.titleLabel()
    
    private lazy var nametitle = factory.textLabel(text: "Your name")
    private lazy var nameText = factory.registrationTextField()
    
    private lazy var nameEmpty = factory.errorLabel()
    private lazy var ageEmpty = factory.errorLabel()
    
    private lazy var ageTitle = factory.textLabel(text: "Your age")
    private lazy var ageText = factory.registrationTextField()
    
    private lazy var genderPicker: UIPickerView = .init()
    
    private lazy var button = factory.registrationButton()
    
    private let dataArray = ["None", "Female", "Male"]
    
    init(
        router: RegistrationRoutingLogic,
        interactor: RegistrationBusinessLogic
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        view.backgroundColor = .systemBackground
    }
    
    func configUI() {
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderPicker)
        genderPicker.delegate = self
        genderPicker.dataSource = self
        view.addSubview(titleText)
        view.addSubview(nametitle)
        view.addSubview(nameText)
        view.addSubview(ageTitle)
        view.addSubview(ageText)
        view.addSubview(genderPicker)
        view.addSubview(button)
        view.addSubview(nameEmpty)
        view.addSubview(ageEmpty)
        nameEmpty.isHidden = true
        ageEmpty.isHidden = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleText.heightAnchor.constraint(equalToConstant: 50),
            
            nametitle.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 50),
            nametitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nametitle.heightAnchor.constraint(equalToConstant: 18),
            
            nameEmpty.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 50),
            nameEmpty.leadingAnchor.constraint(equalTo: nametitle.trailingAnchor, constant: 30),
            nameEmpty.heightAnchor.constraint(equalToConstant: 18),
            
            nameText.topAnchor.constraint(equalTo: nametitle.bottomAnchor, constant: 9),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameText.heightAnchor.constraint(equalToConstant: 50),
            
            ageTitle.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 50),
            ageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ageTitle.heightAnchor.constraint(equalToConstant: 18),
            
            ageEmpty.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 50),
            ageEmpty.leadingAnchor.constraint(equalTo: ageTitle.trailingAnchor, constant: 30),
            ageEmpty.heightAnchor.constraint(equalToConstant: 18),
            
            ageText.topAnchor.constraint(equalTo: ageTitle.bottomAnchor, constant: 9),
            ageText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ageText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ageText.heightAnchor.constraint(equalToConstant: 50),
            
            genderPicker.topAnchor.constraint(equalTo: ageText.bottomAnchor, constant: 30),
            genderPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderPicker.heightAnchor.constraint(equalToConstant: 150),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        interactor.buttonTapped(RegistrationInfo.Request(
            name: nameText.text ?? "",
            age: ageText.text ?? "",
            sex: dataArray[genderPicker.selectedRow(inComponent: 0)]
        ))
    }
}

extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension RegistrationViewController: RegistrationDisplayLogic {
    func displayMainScreen(_ viewModel: Model.ViewModel) {
        router.openMainScreen(viewModel)
    }

    func displayError(_ response: Model.Response) {
        nameEmpty.text = response.nameError
        ageEmpty.text = response.ageError
        nameEmpty.isHidden = false
        ageEmpty.isHidden = false
    }
}
