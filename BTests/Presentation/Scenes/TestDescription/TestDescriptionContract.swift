//
//  TestDescriptionContract.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

protocol TestDescriptionRouter: AnyObject {
    func pushTest(with: TestData)
}

protocol TestDescriptionBuilder {
    func build(with: TestData) -> UIViewController
}

protocol TestDescriptionViewModel {
    var test: Test { get }
    func openTest()
}
