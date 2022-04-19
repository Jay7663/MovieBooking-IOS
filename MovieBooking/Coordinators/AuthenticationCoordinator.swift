import Foundation
import UIKit

class AuthenticationCoordinator: Coordinator {
    
    var navController: UINavigationController?
    
    init (_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
        let homeScreenVC = ViewController.instantiate(from: .main)
        homeScreenVC.coordinator = self
        navController?.pushViewController(homeScreenVC, animated: true)
    }
    
    func startLogIn() {
        let logInVC = LogInViewController.instantiate(from: .main)
        logInVC.coordinator = self
        navController?.pushViewController(logInVC, animated: true)
    }
    
    func startSignUp() {
        let signUpVC = SignUpViewController.instantiate(from: .main)
        signUpVC.coordinator = self
        navController?.pushViewController(signUpVC, animated: true)
    }
    
    func popViewController() {
        navController?.popViewController(animated: false)
    }
    
    func finish() {
    }
    
    func finishToRoot() {
    }
    
}//End of class
