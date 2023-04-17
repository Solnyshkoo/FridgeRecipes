import UIKit

final class PersonalInfoView: UIView {
    private enum Constants {
        static let nameFontSize: CGFloat = 32
        static let imageSize: CGFloat = 100
        static let settingsSize: CGFloat = 25
        static let infoFontSize: CGFloat = 17
        static let textTopOffset: CGFloat = 5
        static let textLeadingOffset: CGFloat = 20
    }
    
    private let name = UILabel()
    private let age = UILabel()
    private let sex = UILabel()
    private let level = UILabel()
    private let imgView = UIImageView()
    
    private let nameEdit = UITextField()
    private let ageEdit = UITextField()
    private let sexEdit = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        layer.cornerRadius = 15
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let height: CGFloat = 128
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
    
    func configure(data: RegistrationInfo.ViewModel) {
        name.text = data.name
        age.text = "Age: " + data.age
        sex.text = "Gender: " + data.sex
        level.text = "Level: " + "1"
        imgView.image = UIImage(named: "level1")
    }
    
    private func configureUI() {
        name.font = UIFont.systemFont(ofSize: Constants.nameFontSize, weight: .bold)
        age.font = UIFont.systemFont(ofSize: Constants.infoFontSize, weight: .regular)
        sex.font = UIFont.systemFont(ofSize: Constants.infoFontSize, weight: .regular)
        level.font = UIFont.systemFont(ofSize: Constants.infoFontSize, weight: .regular)
        
        name.textAlignment = .left
        age.textAlignment = .left
        sex.textAlignment = .left
        level.textAlignment = .left
        
        name.translatesAutoresizingMaskIntoConstraints = false
        age.translatesAutoresizingMaskIntoConstraints = false
        sex.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        level.translatesAutoresizingMaskIntoConstraints = false

        imgView.layer.cornerRadius = 15
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill

        addSubview(name)
        addSubview(age)
        addSubview(sex)
        addSubview(imgView)
        addSubview(level)
     
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            imgView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            imgView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            
            name.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: trailingAnchor),
            name.heightAnchor.constraint(equalToConstant: Constants.nameFontSize),
            
            level.topAnchor.constraint(equalTo: name.bottomAnchor, constant: Constants.textTopOffset),
            level.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: Constants.textLeadingOffset),
            level.trailingAnchor.constraint(equalTo: trailingAnchor),
            level.heightAnchor.constraint(equalToConstant: Constants.infoFontSize + 1),
            
            age.topAnchor.constraint(equalTo: level.bottomAnchor, constant: Constants.textTopOffset),
            age.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: Constants.textLeadingOffset),
            age.trailingAnchor.constraint(equalTo: trailingAnchor),
            age.heightAnchor.constraint(equalToConstant: Constants.infoFontSize + 1),
            
            sex.topAnchor.constraint(equalTo: age.bottomAnchor, constant: Constants.textTopOffset),
            sex.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: Constants.textLeadingOffset),
            sex.trailingAnchor.constraint(equalTo: trailingAnchor),
            sex.heightAnchor.constraint(equalToConstant: Constants.infoFontSize + 1),
            
        ])
    }
}
