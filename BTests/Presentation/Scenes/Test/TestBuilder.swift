//
//  TestBuilder.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class TestBuilderImpl: TestBuilder {
    func build() -> UIViewController {
        let view = TestView()

        let router = TestRouterImpl(view: view)
        let viewModel = TestViewModelImpl(router: router)
        view.viewModel = viewModel

        return view
    }
}

