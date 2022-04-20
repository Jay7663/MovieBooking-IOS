import UIKit

class ViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    var coordinator: AuthenticationCoordinator?
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func btnLogIn(_ sender: UIButton) {
        coordinator?.startLogIn()
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        coordinator?.startSignUp()
    }
    
} // End of Class

