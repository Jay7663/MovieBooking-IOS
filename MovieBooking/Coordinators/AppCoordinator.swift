import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var navController: UINavigationController?
    
    init (_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
        if let navController = navController {
            let mainVC = AuthenticationCoordinator(navController)
            mainVC.start()
        }
    }
    
    func finish() {
        
    }
    
    func finishToRoot() {
        
    }
    
} //End of class
