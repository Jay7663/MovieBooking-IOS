import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var navController: UINavigationController?
    
    init(_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
        if let navViewController = navController {
            let mainCoordinator = HomeScreenCoordinator(navViewController)
            mainCoordinator.start()
        }
    }
    
    func finish() {
        
    }
    
    func finishToRoot() {
        
    }
    
}// End of class
