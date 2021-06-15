//
//  TestListRouter.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class TestListRouterImpl: TestListRouter {
    private let view: UIViewController

    init(view: UIViewController) {
        self.view = view
    }
    func pushTestDescriotion() {
        let builder = TestDescriptionBuilderImpl()
        let testDescriptionView = builder.build()
        view.navigationController?.pushViewController(testDescriptionView, animated: true)
    }
}
