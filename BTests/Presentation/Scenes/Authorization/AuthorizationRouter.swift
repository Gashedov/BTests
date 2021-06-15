//
//  AuthorizationRouter.swift
//  BTests
//
//  Created by Artem Gorshkov on 14.06.21.
//

import UIKit

class AuthorizationRouterImpl: AuthorizationRouter {
    private let view: UIViewController

    init(view: UIViewController) {
        self.view = view
    }
    
    func presentMainScreen() {
        let mainScreenView = MainScreenBuilderImpl().build()
        let navigation = UINavigationController(rootViewController: mainScreenView)
        navigation.isModalInPresentation = true
        navigation.modalPresentationStyle = .fullScreen
        view.present(navigation, animated: true)
    }
}
