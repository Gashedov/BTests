//
//  TestViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import Moya

class TestViewModelImpl: TestViewModel {
    private let apiProvider = MoyaProvider<API>()
    private let router: TestRouter

    var items: [TestQuestion] = []

    var delegate: TestViewModelDelegate?

    init(router: TestRouter) {
        self.router = router
    }

    func openTestResults() {
        router.pushTestResult()
    }

    func fetchItems() {
    }
}
