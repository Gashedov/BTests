//
//  TestDescriptionViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import Foundation

class TestDescriptionViewModelImpl: TestDescriptionViewModel {
    private let router: TestDescriptionRouter

    init(router: TestDescriptionRouter) {
        self.router = router
    }

    func openTest() {
        router.pushTest()
    }
}
