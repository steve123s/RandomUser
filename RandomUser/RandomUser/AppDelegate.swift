//
//  AppDelegate.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 27/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = UIStoryboard.loadMainStoryboardController(named: .ProfileNavigationController)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        return true
    }

}

