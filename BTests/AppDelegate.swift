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
        var controller: UIViewController = CategoryListView()
        if !UserDefaultsService.appDidRunBefore {
            controller = WelcomeScreenViewController()
            UserDefaultsService.appDidRunBefore = true
        }
        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
        return true
    }
}

