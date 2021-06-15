//
//  TestResultViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import Foundation

class TestResultViewModelImpl: TestResultViewModel {
    private let router: TestResultRouter

    init(router: TestResultRouter) {
        self.router = router
    }

    func goToMainScreen() {
        router.popToMainScreen()
    }

    func openNextTest() {
        router.openNextTest()
    }
}

