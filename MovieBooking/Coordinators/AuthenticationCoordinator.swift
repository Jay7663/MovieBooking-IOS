import Foundation
import UIKit

class AuthenticationCoordinator: Coordinator {
    
    var navController: UINavigationController?
    let userDefaults = UserManager()
    
    init (_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
        userDefaults.isUserLogin ? goToHomeScreen() : goToAuthenticationVC()
    }
    
    func goToAuthenticationVC() {
        let authenticationVC = ViewController.instantiate(from: .main)
        authenticationVC.coordinator = self
        navController?.pushViewController(authenticationVC, animated: true)
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
    
    func goToHomeScreen() {
        if let navController = navController {
            let homeScreenCoordinator = HomeScreenCoordinator(navController)
            homeScreenCoordinator.start()
        }
    }
    
    func finish() {
    }
    
    func finishToRoot() {
    }
    
}//End of class
