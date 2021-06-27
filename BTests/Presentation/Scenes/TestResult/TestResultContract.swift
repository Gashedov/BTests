//
//  TestResultContract.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

protocol TestResultRouter: AnyObject {
    func popToMainScreen()
    func openNextTest()
}

protocol TestResultBuilder {
    func build(with: TestResponseData) -> UIViewController
}

protocol TestResultViewModel {
    func getResultTitle() -> String
    func goToMainScreen()
    func openNextTest()
}
