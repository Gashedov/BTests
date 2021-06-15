//
//  AuthorizationBuilder.swift
//  BTests
//
//  Created by Artem Gorshkov on 14.06.21.
//

import UIKit

class AuthorizationBuilderImpl: AuthorizationBuilder {
    func build() -> UIViewController {
        let view = AuthorizationView()

        let router = AuthorizationRouterImpl(view: view)
        let viewModel = AuthorizationViewModelImpl(router: router)
        view.viewModel = viewModel

        return view
    }
}
