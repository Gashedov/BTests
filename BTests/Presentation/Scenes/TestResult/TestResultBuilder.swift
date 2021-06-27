//
//  TestResultBuilder.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class TestResultBuilderImpl: TestResultBuilder {
    func build(with data: TestResponseData) -> UIViewController {
        let view = TestResultView()

        let router = TestResultRouterImpl(view: view)
        let viewModel = TestResultViewModelImpl(
            router: router,
            resultData: data
        )
        view.viewModel = viewModel

        return view
    }
}

