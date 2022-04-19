import Foundation
import UIKit

class CommonFunctions {
    
    static func generateAlert(show message: String, _ context: UIViewController) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        context.present(alert, animated: true, completion: nil)
    }
    
}
