import UIKit

public protocol StoriesProtocol: UIView {
    func start()
}

final class UIStackViewStories: UIView, StoriesProtocol {
    // Cuszomize defined UIProgressView and UIButton object.
    var progressView2: UIProgressView!
    let iv1 = UIImageView()
    var buttonForward = UIButton()
    var buttonBack = UIButton()
    
    private lazy var pickers = (0..<storiesString.storiesString.count).map() {_ in UIProgressView(frame: .zero) }
    private var storiesString: StoriesModels.ViewModel // ["first", "first_2"]
    private var currentIndex = 0

    var timer:Timer? = nil
    
    
    func start() {
        self.timer?.invalidate()
        currentIndex = 0
        pickers.forEach { item in
            item.progress = 0
        }
        iv1.image =  UIImage(named: storiesString.storiesString[currentIndex])
        startTimer()
    }

    
    init(data: StoriesModels.ViewModel) {
        storiesString = data
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        initProgressView2Btn2()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Initialize btn2 and progressView2.
    func initProgressView2Btn2(){
        addSubview(iv1)

        let width = (UIScreen.main.bounds.width - CGFloat(((pickers.count + 1 ) * 15))) / CGFloat( pickers.count)
        var offset: CGFloat = 15
        pickers.forEach { item in
            item.isHidden = false
            item.progress = 0
            item.trackTintColor = .secondarySystemBackground
            item.progressTintColor = .label
            addSubview(item)
            item.frame = CGRect(
                x: offset,
                y: 20,
                width: width,
                height: item.intrinsicContentSize.height
            )
            offset += 15
            offset += width
        }
        
        iv1.translatesAutoresizingMaskIntoConstraints = false
        iv1.layer.masksToBounds = true
        iv1.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            iv1.topAnchor.constraint(equalTo: topAnchor),
            iv1.leadingAnchor.constraint(equalTo: leadingAnchor),
            iv1.trailingAnchor.constraint(equalTo: trailingAnchor),
            iv1.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        addSubview(buttonForward)
        addSubview(buttonBack)

        buttonForward.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        
        buttonForward.backgroundColor = .clear
        buttonBack.backgroundColor = .clear

        buttonForward.addTarget(self, action: #selector(moveForward(_:)), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(moveBack(_:)), for: .touchUpInside)
//
        let buttonWidth = UIScreen.main.bounds.width / 2

        NSLayoutConstraint.activate([
            buttonForward.topAnchor.constraint(equalTo: topAnchor),
            buttonForward.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonForward.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonForward.widthAnchor.constraint(equalToConstant: buttonWidth),
//
            buttonBack.topAnchor.constraint(equalTo: topAnchor),
            buttonBack.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonBack.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonBack.widthAnchor.constraint(equalToConstant: buttonWidth),
        ])
        
//        startTimer()
    }

    /* This function will start a timer object and start the timer. */
    func startTimer() -> Void{
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startDownload), userInfo: nil, repeats: true)
       
    }
       

    @objc func startDownload() {
        showProgressView(progressView: pickers[currentIndex])
    }
    
    @objc func moveForward(_ sender: UIButton) {
        self.timer?.invalidate() //  Invalidate the timer object to stop it.
        
        if !(currentIndex == pickers.count - 1) {
            pickers[currentIndex].progress = 1
            currentIndex += 1
            iv1.image =  UIImage(named: storiesString.storiesString[currentIndex])
            startTimer()
        }
    }
    
    @objc func moveBack(_ sender: UIButton) {
        self.timer?.invalidate() //  Invalidate the timer object to stop it.
        
        if !(currentIndex == 0) {
            pickers[currentIndex].progress = 0
            currentIndex -= 1
            pickers[currentIndex].progress = 0
            iv1.image =  UIImage(named: storiesString.storiesString[currentIndex])
            startTimer()
        }
    }
    
    /* This function will display the UIProgressView object. */
    func showProgressView(progressView: UIProgressView){
        
        // Get the progressView's progress.
        var currProgress = progressView.progress
           
        // progress value plus 0.1.
        progressView.progress = currProgress + 0.1
           
        currProgress = progressView.progress
           
        // If current progress value is 1.5
        if(currProgress == 1.0){
            
            // Invalidate the timer object to stop it.
            self.timer?.invalidate()
               
            if !(currentIndex == pickers.count - 1) {
                currentIndex += 1
                iv1.image =  UIImage(named: storiesString.storiesString[currentIndex])
                startTimer()
            }
            
            
            print("All done")
        }
        
    }
}
