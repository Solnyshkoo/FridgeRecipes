import UIKit

final class NutritionViewController: UIViewController {
    private let interactor: NutritionBusinessLogic
    private let factory = NutritionFactory()
    
    private lazy var scrollView = UIScrollView()
    private let caloriesInfo = CaloriesView()
    private lazy var mainTitle = factory.makeTittleLabel()
    private lazy var bigSeparator = factory.makeSeparaator()
    private lazy var smallSeparator = factory.makeSeparaator()
    private lazy var separator = factory.makeSeparaator()
    private lazy var amountInfo = factory.makeDiscriptionLabel()
    private lazy var dailyValueLabel = factory.makeSubtitleLabel()
    private let tableView: UITableView = .init()
    
    private var l = 1
    
    private var nutritionInfo: NutritionModel.ViewModel = .init(
        calorie: 0,
        all: [TotalDaily](repeating: TotalDaily(label: "", quantity: 0, unit: .g), count: 26),
        cellId: [String](repeating: "main", count: 26)
    )
    
    init(interactor: NutritionBusinessLogic, data: [String]) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        self.modalPresentationStyle = .pageSheet
        self.isModalInPresentation = false
        interactor.loadNutritionInfo(NutritionModel.Request(text: data))
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

    private enum Constants {
        static let sidesOffset: CGFloat = 15
    }
    
    private func configUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainTitle)
        scrollView.addSubview(bigSeparator)
        scrollView.addSubview(amountInfo)
        scrollView.addSubview(caloriesInfo)
        scrollView.addSubview(smallSeparator)
        scrollView.addSubview(separator)
        scrollView.addSubview(dailyValueLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        caloriesInfo.translatesAutoresizingMaskIntoConstraints = false
        dailyValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        caloriesInfo.config(count: "-")
        view.addSubview(tableView)
        tableView.separatorColor = .clear
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(NutritionMainInfoView.self, forCellReuseIdentifier: NutritionMainInfoView.cellId)
        tableView.register(NutritionInfoView.self, forCellReuseIdentifier: NutritionInfoView.cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainTitle.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainTitle.heightAnchor.constraint(equalToConstant: 33),
            
            bigSeparator.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 15),
            bigSeparator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            bigSeparator.widthAnchor.constraint(equalToConstant: view.bounds.width - 2 * Constants.sidesOffset),
            bigSeparator.heightAnchor.constraint(equalToConstant: 10),
            
            amountInfo.topAnchor.constraint(equalTo: bigSeparator.bottomAnchor, constant: 15),
            amountInfo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            amountInfo.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constants.sidesOffset),
            amountInfo.heightAnchor.constraint(equalToConstant: amountInfo.intrinsicContentSize.height),
            
            caloriesInfo.topAnchor.constraint(equalTo: amountInfo.bottomAnchor, constant: 15),
            caloriesInfo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            caloriesInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            caloriesInfo.heightAnchor.constraint(equalToConstant: caloriesInfo.intrinsicContentSize.height),
            
            smallSeparator.topAnchor.constraint(equalTo: caloriesInfo.bottomAnchor, constant: 15),
            smallSeparator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            smallSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            smallSeparator.heightAnchor.constraint(equalToConstant: 5),
            
            dailyValueLabel.topAnchor.constraint(equalTo: smallSeparator.bottomAnchor, constant: 2.5),
            dailyValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            dailyValueLabel.heightAnchor.constraint(equalToConstant: 15),
            
            separator.topAnchor.constraint(equalTo: smallSeparator.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.sidesOffset),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            separator.heightAnchor.constraint(equalToConstant: 2),
            
            tableView.topAnchor.constraint(equalTo: separator.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidesOffset),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesOffset),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

extension NutritionViewController: NutritionDisplayLogic {
    func displayError(error: String) {
        print("error")
    }
    
    func displayInfo(_ viewModel: Model.ViewModel) {
        nutritionInfo = viewModel.plus(data: nutritionInfo)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.l = 1
            self.tableView.reloadData()
            self.caloriesInfo.config(count: String(self.nutritionInfo.calorie))
        }
    }
    
    func addInfo(_ viewModel: Model.ViewModel) {
        nutritionInfo = viewModel.plus(data: nutritionInfo)
    }
}

extension NutritionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if nutritionInfo.all.count == 0 {
            return UITableViewCell()
        }
        let iteminfo = nutritionInfo.all[indexPath.row + l - 1]
        let item2info = nutritionInfo.all[indexPath.row + l]
        let cellinfo = nutritionInfo.cellId[indexPath.row]
        
        l += 1
        guard let iteminfo = iteminfo else {
            return UITableViewCell()
        }
        if cellinfo == "main" {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NutritionMainInfoView.cellId,
                for: indexPath
            ) as? NutritionMainInfoView
            
            cell?.config(data: iteminfo, persentage: item2info)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NutritionInfoView.cellId,
                for: indexPath
            ) as? NutritionInfoView
            
            cell?.config(data: iteminfo, persentage: item2info)
            return cell ?? UITableViewCell()
        }
    }
}
