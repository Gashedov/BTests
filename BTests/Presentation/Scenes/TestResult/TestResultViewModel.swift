//
//  TestResultViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import Foundation

class TestResultViewModelImpl: TestResultViewModel {
    private let router: TestResultRouter
    private let testResultData: TestResponseData

    init(
        router: TestResultRouter,
        resultData: TestResponseData
    ) {
        self.router = router
        self.testResultData = resultData
    }

    func getResultTitle() -> String {
        if let faculty = testResultData.faculty {
            return faculty.name
        } else if let specialty = testResultData.specialty {
            return specialty.name
        } else if let otherResult = testResultData.otherResult {
            return otherResult != "null" ? otherResult : R.string.localizable.undefinedResult()
        }
        return R.string.localizable.undefinedResult()
    }

    func goToMainScreen() {
        router.popToMainScreen()
    }

    func openNextTest() {
        router.openNextTest()
    }
}

