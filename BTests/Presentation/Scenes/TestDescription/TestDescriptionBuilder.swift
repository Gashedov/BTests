//
//  TestDescriptionBuilder.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class TestDescriptionBuilderImpl: TestDescriptionBuilder {
    func build() -> UIViewController {
        let view = TestDescriptionView()

        let router = TestDescriptionRouterImpl(view: view)
        let viewModel = TestDescriptionViewModelImpl(router: router)
        view.viewModel = viewModel

        return view
    }
}
