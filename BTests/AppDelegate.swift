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

        if !UserDefaultsStore.shared.appDidRunBefore {
            UserDefaultsStore.shared.appDidRunBefore = true
            window?.rootViewController = WelcomeScreenViewController()
            window?.makeKeyAndVisible()
            return true
        }

        if !userHasBeenAuthenticated() {
            window?.rootViewController = AuthorizationBuilderImpl().build()
            window?.makeKeyAndVisible()
            return true
        }

        window?.rootViewController = UINavigationController(
            rootViewController: MainScreenBuilderImpl().build()
        )
        window?.makeKeyAndVisible()
        return true
    }

    private func userHasBeenAuthenticated() -> Bool {
        if UserDefaultsStore.shared.userName != nil ||
            UserDefaultsStore.shared.userSurname != nil ||
            UserDefaultsStore.shared.userPhoneNumber != nil {
            return true
        }
        return false
    }
}



