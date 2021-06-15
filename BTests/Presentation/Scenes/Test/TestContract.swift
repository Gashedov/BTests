//
//  TestContract.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

protocol TestRouter: AnyObject {
    func pushTestResult()
}

protocol TestBuilder {
    func build() -> UIViewController
}

protocol TestViewModel {
    var items: [TestQuestion] { get }
    var delegate: TestViewModelDelegate? { get set }

    func fetchItems()
    func openTestResults()
}

protocol TestViewModelDelegate: AnyObject {
    func itemsFetched()
}

