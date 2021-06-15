//
//  MainScreenBuilder.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class MainScreenBuilderImpl: MainScreenBuilder {
    func build() -> UIViewController {
        let view = MainScreenView()

        let router = MainScreenRouterImpl(view: view)
        let viewModel = MainScreenViewModelImpl(router: router)
        view.viewModel = viewModel

        return view
    }
}
