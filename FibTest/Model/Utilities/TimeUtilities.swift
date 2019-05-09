import UIKit

class TimeUtilities: NSObject {
    class func getElaspedMilliseconds(_ startTimeInMillis: UInt) -> UInt {
        let currentTime = getCurrentDateInMillis()
        return currentTime - startTimeInMillis
    }
    
    class func getCurrentDateInMillis() -> UInt {
        return UInt(Date().timeIntervalSince1970 * 1000)
    }
}
