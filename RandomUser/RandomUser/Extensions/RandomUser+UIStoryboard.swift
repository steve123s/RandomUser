//
//  RandomUser+Nibs.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 28/03/21.
//

import UIKit

extension UIStoryboard {
    
    enum Main: String {
        case ProfileNavigationController
        case ProfileViewController
    }
    
    static func loadMainStoryboardController(named controller: Main) -> UIViewController {
        let storyboardName = "\(type(of: controller))"
        let uiStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: controller.rawValue)
    }

}
