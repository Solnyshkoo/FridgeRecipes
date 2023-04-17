import UIKit

final class RewardCell: UIView {
    static let cellId = "RewardCell"
    private let imgView = UIImageView()
    private let titleReward = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 80, height: 80)
    }

    func configure(data: RewardInfo.ViewModel) {
        titleReward.text = data.rewardText
        imgView.image = UIImage(named: data.rewardImage)
    }
    
    private func configureUI() {
        addSubview(imgView)
        addSubview(titleReward)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        titleReward.translatesAutoresizingMaskIntoConstraints = false

        titleReward.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleReward.textAlignment = .left
        titleReward.textColor = .systemGray
    
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imgView.widthAnchor.constraint(equalToConstant: 60),
            imgView.heightAnchor.constraint(equalToConstant: 60),
            
            titleReward.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 5),
            titleReward.centerXAnchor.constraint(equalTo: imgView.centerXAnchor),
            titleReward.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
}
 
