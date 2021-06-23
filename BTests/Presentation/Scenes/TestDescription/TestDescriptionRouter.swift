//
//  TestDescriptionRouter.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class TestDescriptionRouterImpl: TestDescriptionRouter {

    private let view: UIViewController

    init(view: UIViewController) {
        self.view = view
    }

    func pushTest(with test: TestData) {
        let testView = TestBuilderImpl().build(with: test)
        view.navigationController?.pushViewController(testView, animated: true)
    }
}
