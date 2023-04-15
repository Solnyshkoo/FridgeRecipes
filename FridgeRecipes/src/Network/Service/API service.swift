import Foundation

final class FetchingRecipesOperation<T>: Operation where T: Decodable {
    private let lockQueue = DispatchQueue(
        label: "com.swiftlee.asyncoperation",
        attributes: .concurrent
    )

    private let type: RequestType
    private let completion: (Result<T, NetworkError>) -> Void

    init(
        type: RequestType,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        self.type = type
        self.completion = completion
    }

    override var isAsynchronous: Bool {
        true
    }

    private var _isExecuting: Bool = false
    private(set) override var isExecuting: Bool {
        get {
            lockQueue.sync { () -> Bool in
                _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync(flags: [.barrier]) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _isFinished: Bool = false
    private(set) override var isFinished: Bool {
        get {
            lockQueue.sync { () -> Bool in
                _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync(flags: [.barrier]) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }

    override func start() {
        isFinished = false
        isExecuting = true
        main()
    }

    override func main() {
        guard let url = type.url else {
            completion(.failure(NetworkError.unableToMakeURL))
//            finish()
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in

            if let error = error {
                self?.completion(.failure(.serverError(error: error)))

                guard let self = self else {
                    self?.finish()
                    return
                }
                self.finish()
                self.start()
                return
            }
            do {
                guard let data = data else {
                    self?.completion(.failure(NetworkError.noResponseData))
//                    self?.finish()
                    return
                }

                let result = try JSONDecoder().decode(T.self, from: data)
                self?.completion(.success(result))
                self?.finish()
            } catch {
                self?.completion(.failure(.parsingError))
                self?.finish()
            }
        }.resume()
    }

    func finish() {
        isExecuting = false
        isFinished = true
    }
}
