import Foundation

private struct AppConstants {
    static let isUserLogin = "isUserLogin"
}

let userManager = UserManager.shared

class UserManager {
    
    // static properties get lazy evaluation and dispatch_once_t for free
    private struct Static {
        static let instance = UserManager()
    }
    
    // this is the Swift way to do singletons
    class var shared: UserManager {
        return Static.instance
    }
    
    // user authentication always begins with a UUID
    private let userDefaults = UserDefaults.standard
    
    var isUserLogin: Bool {
        get {
            return userDefaults.object(forKey: AppConstants.isUserLogin) as? Bool ?? false
        }
        
        set (newValue) {
            userDefaults.set(newValue, forKey: AppConstants.isUserLogin)
            userDefaults.synchronize()
        }
    }
    
}//End of Class
