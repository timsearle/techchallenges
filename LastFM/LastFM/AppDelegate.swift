//
//  AppDelegate.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        guard let rootViewController = window?.rootViewController as? UINavigationController else {
            fatalError("Application expects rootViewController to be UINavigationController")
        }
        
        self.appCoordinator = AppCoordinator(navigationController: rootViewController)
        self.appCoordinator?.start()
        
        return true
    }
}
