import UIKit
import FirebaseAuth

class LogInViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    var coordinator: AuthenticationCoordinator?
    var activeTextField: UITextField? = nil
    var authenticationViewModel = AuthenticationViewModel()
    
    // MARK: - Outlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        initialData()
    }
    
    // MARK: - File Private Functions
    fileprivate func bindViewModel() {
        authenticationViewModel.logInStatus = { message in
            CustomAlert.customAlert(message: message, body: "", viewController: self)
        }
    }
    
    fileprivate func initialData() {
        hideKeyboardWhenTappedAround()
        viewEmail.applyBorder()
        viewPassword.applyBorder()
        self.navigationItem.hidesBackButton = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        var shouldMoveViewUp = false
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    // MARK: - Actions
    @IBAction func btnLogIn(_ sender: UIButton) {
        authenticationViewModel.doLogIn(tfEmail.text ?? "", tfPassword.text ?? "")
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        coordinator?.popViewController()
        coordinator?.startSignUp()
    }
    
} // End of Class

// MARK: - UITextFieldDelegate
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.tfEmail:
            self.tfPassword.becomeFirstResponder()
        default:
            self.tfPassword.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
} // End of Extension
