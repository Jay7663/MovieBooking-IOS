import Foundation
import UIKit

extension UIView {
    
    func applyBorder() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = CGFloat(10)
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
}
