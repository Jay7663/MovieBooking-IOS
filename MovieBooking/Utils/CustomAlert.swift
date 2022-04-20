//
//  CustomAlert.swift
//  MovieBooking
//
//  Created by Yagnik Bavishi on 19/04/22.
//

import Foundation
import UIKit
import SwiftMessages

class CustomAlert {
    
    // MARK: - Static Functions
    static func customAlert(message: String, body: String, viewController: UIViewController) {
        let view = MessageView.viewFromNib(layout: .cardView)
        switch(message) {
        case "Success" :
            view.configureTheme(.success)
        case "Unsuccess" :
            view.configureTheme(.error)
        case "Data Loaded Error" :
            view.configureTheme(.info)
        default:
            view.configureTheme(.warning)
        }
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        view.button?.isHidden = true
        config.duration = .seconds(seconds: 2)
        config.dimMode = .gray(interactive: true)
        view.configureDropShadow()
        view.configureContent(title: message, body: body)
        SwiftMessages.show(config: config,view: view)
    }
    
}// End of class
