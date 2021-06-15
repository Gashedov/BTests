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
    func build() -> UIViewController
}

protocol TestResultViewModel {
    func goToMainScreen()
    func openNextTest()
}
