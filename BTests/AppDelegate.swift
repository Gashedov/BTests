//
//  AppDelegate.swift
//  BTests
//
//  Created by Artem Gorshkov on 28.03.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

//        if !UserDefaultsService.appDidRunBefore {
        UserDefaultsStore.shared.appDidRunBefore = true
            window?.rootViewController = WelcomeScreenViewController()
            window?.makeKeyAndVisible()
            return true
//        }
//
//        window?.rootViewController = UINavigationController(
//            rootViewController: CategoryListView()
//        )
//        window?.makeKeyAndVisible()
//        return true
    }
}

