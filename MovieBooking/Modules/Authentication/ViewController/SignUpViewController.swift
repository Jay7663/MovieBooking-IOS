import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    var coordinator: AuthenticationCoordinator?
    var authenticationViewModel = AuthenticationViewModel()
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var viewLastName: UIView!
    
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        initialData()
    }
    
    // MARK: - File Private Functions
    fileprivate func initialData() {
        hideKeyboardWhenTappedAround()
        viewEmail.applyBorder()
        viewPassword.applyBorder()
        viewFirstName.applyBorder()
        viewLastName.applyBorder()
        self.navigationItem.hidesBackButton = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func bindViewModel() {
        authenticationViewModel.signUpStatus = { message in
            if message == "Success" {
                self.coordinator?.goToHomeScreen()
            }
            CustomAlert.customAlert(message: message, body: "", viewController: self)
        }
    }
    
    @objc fileprivate func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    @objc fileprivate func keyboardWillHide(notification:NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    // MARK: - Actions
    @IBAction func btnSignUp(_ sender: UIButton) {
        authenticationViewModel.doSignUp(tfEmail.text ?? "", tfPassword.text ?? "", tfFirstName.text ?? "", tfLastName.text ?? "")
    }
    
    @IBAction func btnLogIn(_ sender: UIButton) {
       // coordinator?.popViewController()
        coordinator?.startLogIn()
    }
    
} // End of Class

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.tfEmail:
            self.tfPassword.becomeFirstResponder()
        case self.tfPassword:
            self.tfFirstName.becomeFirstResponder()
        case self.tfFirstName:
            self.tfLastName.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
} // End of Extension
