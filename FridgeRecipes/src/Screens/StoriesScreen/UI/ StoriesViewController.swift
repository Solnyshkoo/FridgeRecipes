import UIKit

final class StoriesViewController: UIViewController {
    private let cubeView = StoriesScrollView()

    private let allStories: [StoriesModels.ViewModel] = [
        StoriesModels.ViewModel(
            storiesString: [
                "stories_1_1", "stories_1_2", "stories_1_3", "stories_1_4", "stories_1_5", "stories_1_6", "stories_1_7"
            ]
        ), StoriesModels.ViewModel(
            storiesString: [
                "stories_2_1", "stories_2_2", "stories_2_3", "stories_2_4", "stories_2_5", "stories_2_6", "stories_2_7",
                "stories_2_8", "stories_2_9", "stories_2_10", "stories_2_11", "stories_2_12", "stories_2_13",
                "stories_2_14", "stories_2_15", "stories_2_16", "stories_2_17", "stories_2_18"
            ]
        ), StoriesModels.ViewModel(
            storiesString: [
                "stories_3_1", "stories_3_2", "stories_3_3", "stories_3_4", "stories_3_5", "stories_3_6", "stories_3_7",
                "stories_3_8", "stories_3_9", "stories_3_10", "stories_3_11", "stories_3_12", "stories_3_13",
                "stories_3_14", "stories_3_15", "stories_3_16", "stories_3_17", "stories_3_18"
            ]),
        
    ]
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        view.addSubview(cubeView)
        
        cubeView.translatesAutoresizingMaskIntoConstraints = false
    
        let l = UIStackViewStories(data: allStories[0])
        let l2 = UIStackViewStories(data: allStories[1])
        let l3 = UIStackViewStories(data: allStories[2])
        cubeView.backgroundColor = .systemBackground
        cubeView.addChildViews([l, l2, l3])
        l.start()
        NSLayoutConstraint.activate([
            cubeView.topAnchor.constraint(equalTo: view.topAnchor),
            cubeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cubeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cubeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createStories() {}
}
