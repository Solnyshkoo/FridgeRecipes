import UIKit

final class TabBar: UITabBarController {
    private let userInfo: RegistrationInfo.ViewModel
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    init(userInfo: RegistrationInfo.ViewModel) {
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let mainScreen = MainAssembly.build()
        let personalScreen = PersonalAssembly.build(data: userInfo)

        setViewControllers([mainScreen, personalScreen], animated: false)

        guard let items = tabBar.items else {
            return
        }
//        let titles = ["Search", "Personal"]
        let imageTitles = ["magnifyingglass", "person"]
        for i in 0 ..< 2 {
            items[i].image = UIImage(systemName: imageTitles[i])
        }
//        ta
    }
}
