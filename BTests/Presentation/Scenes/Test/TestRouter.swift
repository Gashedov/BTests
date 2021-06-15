//
//  TestRouter.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class TestRouterImpl: TestRouter {
    private let view: UIViewController

    init(view: UIViewController) {
        self.view = view
    }
    func pushTestResult() {
        let builder = TestResultBuilderImpl()
        let testResultsView = builder.build()
        view.navigationController?.pushViewController(testResultsView, animated: true)
    }
}
