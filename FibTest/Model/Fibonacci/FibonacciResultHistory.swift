import UIKit

class FibonacciResultHistory: NSObject {
    public static let instance = FibonacciResultHistory()
    
    private var history = [FibonacciTimeResult]()
    
    private override init() {}
    
    public func getHistory() -> [FibonacciTimeResult] {
        let history = self.history
        return history
    }
    
    public func recordNewResult(_ result: FibonacciTimeResult) {
        self.history.append(result)
    }
}
