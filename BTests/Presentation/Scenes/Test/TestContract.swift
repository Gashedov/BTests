//
//  TestContract.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

protocol TestRouter: AnyObject {
    func pushTestResult(with: TestResponseData)
    func popToMainScreen()
}

protocol TestBuilder {
    func build(with: TestData) -> UIViewController
}

protocol TestViewModel {
    var items: [TestQuestion] { get }
    var delegate: TestViewModelDelegate? { get set }

    func openTestResults(with: TestResponseData)
    func addAnswer(withNumber: Int, andQuestionNumber: Int)
    func completeTest()
}

protocol TestViewModelDelegate: AnyObject {
    func itemsFetched()
}

