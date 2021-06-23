//
//  TestBuilder.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class TestBuilderImpl: TestBuilder {
    func build(with test: TestData) -> UIViewController {
        let view = TestView()

        let router = TestRouterImpl(view: view)
        let viewModel = TestViewModelImpl(
            router: router,
            testData: test
        )
        view.viewModel = viewModel
        return view
    }
}

