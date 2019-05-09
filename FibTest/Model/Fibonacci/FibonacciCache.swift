import UIKit

class FibonacciCache: NSObject {
    public static let shared = FibonacciCache()
    private var cache: [UInt] = [0, 1]
    
    private override init() {} //Cannot be initialize publically
    
    public func growCacheToN(_ n: Int) {
        if n >= cache.count {
            for i in cache.count...n {
                cache.append(cache[i-2] + cache[i-1])
            }
        }
    }
    
    public func getAllResultsUpToN(_ n: Int) -> [UInt] {
        return Array(cache[0...n])
    }
}
