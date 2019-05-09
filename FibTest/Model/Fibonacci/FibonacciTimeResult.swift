import UIKit

class FibonacciTimeResult: NSObject {
    let n: Int
    let result: UInt
    let timeElapsed: UInt
    
    init(n: Int, result: UInt, timeElapsed: UInt) {
        self.n = n
        self.result = result
        self.timeElapsed = timeElapsed
        
        super.init()
    }
}
