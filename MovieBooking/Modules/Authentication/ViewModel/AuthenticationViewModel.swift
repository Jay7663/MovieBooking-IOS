import UIKit
import FirebaseAuth
import FirebaseFirestore

class AuthenticationViewModel {
    
    // MARK: - Variables
    var logInStatus: ((String) -> Void)?
    var signUpStatus: ((String) -> Void)?
    
    // MARK: - File Private Functions
    func doLogIn(_ email: String, _ password: String) {
        let validationResult = validateFieldsforLogIn(email, password)
        if let validationResult = validationResult {
            logInStatus?(validationResult)
        } else {
            auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let uSelf = self else { return }
                if let _ = error {
                    uSelf.logInStatus?("The user may have been deleted")
                } else {
                    uSelf.logInStatus?("Success Log In")
                }
            }
        }
    }
    
    fileprivate func validateFieldsforLogIn(_ email: String, _ password: String) -> String? {
        if email.isEmpty {
            return "Email is Empty"
        } else if password.isEmpty {
            return "Password is Empty"
        } else if password.count < 8 {
            return "Need atleast 8 characters"
        } else if !email.contains("@") || !email.contains(".") {
            return "Wrong email"
        }
        return nil
    }
    
    func doSignUp(_ email: String, _ password: String, _ firstName: String, _ lastName: String) {
        let validationResult = validateSignUp(email, password, firstName, lastName)
        
        if let validationResult = validationResult {
            signUpStatus?(validationResult)
        } else {
            auth.createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let uSelf = self else { return }
                if error != nil {
                    uSelf.signUpStatus?("Error in SignUp")
                } else {
                    if let uid = result?.user.uid {
                        db.collection("users").document(uid).setData(["firstname":firstName, "lastname":lastName])
                        uSelf.signUpStatus?("SignUp Success")
                    }
                }
            }
        }
    }
    
    fileprivate func validateSignUp(_ email: String, _ password: String, _ firstName: String, _ lastName: String) -> String? {
        if (email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
            return "All fields are required"
        } else if password.count < 8 {
            return "Need atleast 8 characters"
        } else if !email.contains("@") || !email.contains(".") {
            return "Wrong email"
        }
        return nil
    }
    
} // End of Class
