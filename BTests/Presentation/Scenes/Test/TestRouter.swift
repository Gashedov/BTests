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
    
    func pushTestResult(with data: TestResponseData) {
        let builder = TestResultBuilderImpl()
        let testResultsView = builder.build(with: data)
        view.navigationController?.pushViewController(testResultsView, animated: true)
    }

    func popToMainScreen() {
        view.navigationController?.popToRootViewController(animated: true)
    }
}
