//
//  TestDescriptionContract.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

protocol TestDescriptionRouter: AnyObject {
    func pushTest()
}

protocol TestDescriptionBuilder {
    func build() -> UIViewController
}

protocol TestDescriptionViewModel {
    func openTest()
}
