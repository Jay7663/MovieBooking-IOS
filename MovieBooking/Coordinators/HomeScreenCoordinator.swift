//
//  HomeScreenCoordinator.swift
//  MovieBooking
//
//  Created by Yagnik Bavishi on 12/04/22.
//

import Foundation
import UIKit

class HomeScreenCoordinator: Coordinator {
    
    var navController: UINavigationController?
    
    init(_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
        if let homeScreenController = UIStoryboard(name: "HomeScreenStoryboard", bundle: nil).instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController {
            homeScreenController.coordinator = self
            navController?.pushViewController(homeScreenController, animated: true)
        }
    }
    
    func finish() {
        
    }
    
    func finishToRoot() {
        
    }
    
}// End of class
