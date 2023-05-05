import UIKit

final class PersonalContainerView: UIView {
    // MARK: - Fields

    private let title = UILabel()
    private let subtitle = UILabel()
    private let arrow = UIImageView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        layer.cornerRadius = 15
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - intrinsicContentSize

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 70)
    }
    
    // MARK: - Configure data

    func configure(text: String, count: Int, isImage: Bool = true) {
        title.text = text
        subtitle.text = "recipes: " + String(count)
        arrow.image = isImage ? UIImage(systemName: "greaterthan") : nil
    }
    
    // MARK: - Configure UI

    private func configureUI() {
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
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            title.heightAnchor.constraint(equalToConstant: 24),
            
            subtitle.topAnchor.constraint(equalTo: centerYAnchor, constant: 5),
            subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subtitle.heightAnchor.constraint(equalToConstant: 15),
            
            arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            arrow.widthAnchor.constraint(equalToConstant: 20),
            arrow.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
