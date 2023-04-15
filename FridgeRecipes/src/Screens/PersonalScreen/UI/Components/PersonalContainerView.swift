import UIKit

final class PersonalContainerView: UIView {
    private let title = UILabel()
    private let subtitle = UILabel()
    private let arrow = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 70)
    }
    
    func configure(text: String, count: Int, isImage: Bool = true) {
        title.text = text
        subtitle.text = "recipes: " + String(count)
        arrow.image = isImage ? UIImage(systemName: "greaterthan") : nil
    }
    
    private func configureUI() {
//        title.textColor = .systemBackground
//        subtitle.textColor = .systemBackground
        arrow.tintColor = .label
        title.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        subtitle.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        title.textAlignment = .left
        subtitle.textAlignment = .left
 
        title.translatesAutoresizingMaskIntoConstraints = false
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false

        
        addSubview(title)
        addSubview(subtitle)
        addSubview(arrow)
        
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 5),
//            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            title.heightAnchor.constraint(equalToConstant: 24),
            
            subtitle.topAnchor.constraint(equalTo: centerYAnchor, constant: 5),
//            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subtitle.heightAnchor.constraint(equalToConstant: 15),
            
            arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            arrow.widthAnchor.constraint(equalToConstant: 20),
            arrow.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
