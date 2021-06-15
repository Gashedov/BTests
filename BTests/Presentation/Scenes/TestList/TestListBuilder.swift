//
//  TestListBuilder.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class TestListBuilderImpl: TestListBuilder {
    func build() -> UIViewController {
        let view = TestListView()

        let router = TestListRouterImpl(view: view)
        let viewModel = TestListViewModelImpl(router: router)
        view.viewModel = viewModel

        return view
    }
}
