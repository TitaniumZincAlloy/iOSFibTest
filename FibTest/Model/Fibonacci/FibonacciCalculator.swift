import UIKit

protocol FibonacciCalculatorDelegate: AnyObject {
    func finishedCalculation(resultsList: [UInt], timedResult: FibonacciTimeResult)
}

class FibonacciCalculator: NSObject {
    weak var delegate: FibonacciCalculatorDelegate?
    
    func calculateFibonacciForN(_ n: Int) {
        self.performCachedFibCalculation(n)
    }
    
    private func performCachedFibCalculation(_ n: Int) {
        let startTimeMillis = TimeUtilities.getCurrentDateInMillis()
        FibonacciCache.shared.growCacheToN(n)
        let allResults = FibonacciCache.shared.getAllResultsUpToN(n)
        let timeElapsed = TimeUtilities.getElaspedMilliseconds(startTimeMillis)
        
        let timedResult = FibonacciTimeResult(n: n, result: allResults[n], timeElapsed: timeElapsed)
        self.delegate?.finishedCalculation(resultsList: allResults, timedResult: timedResult)
        
    }
}
