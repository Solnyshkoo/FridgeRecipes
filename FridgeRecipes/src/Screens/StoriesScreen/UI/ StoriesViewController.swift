import UIKit

final class  StoriesViewController: UIViewController {
    
    private let cubeView = StoriesScrollView()

    private let allStories: [StoriesModels.ViewModel] = [StoriesModels.ViewModel(
        storiesString: ["stories_1_1", "stories_1_2", "stories_1_3", "stories_1_4", "stories_1_5", "stories_1_6", "stories_1_7"]
    ), StoriesModels.ViewModel(storiesString: ["stories_2_1", "stories_2_2", "stories_2_3", "stories_2_1", "stories_2_1",
                                               "stories_2_1", "stories_2_2", "stories_2_3", "stories_2_1", "stories_2_1"])]
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        view.backgroundColor = .black
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .pageSheet
        self.isModalInPresentation = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        view.addSubview(cubeView)
        
        cubeView.translatesAutoresizingMaskIntoConstraints = false
    
        let l = UIStackViewStories(data: allStories[0])
        let l2 = UIStackViewStories(data: allStories[1])
        cubeView.backgroundColor = .systemBackground
        cubeView.addChildViews([l, l2])
        l.start()
        NSLayoutConstraint.activate([
            cubeView.topAnchor.constraint(equalTo: view.topAnchor),
            cubeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cubeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cubeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createStories() {
        
    }
    
}

