//
//  AuthorizationContract.swift
//  BTests
//
//  Created by Artem Gorshkov on 14.06.21.
//

import UIKit

protocol AuthorizationRouter: AnyObject {
    func presentMainScreen()
}

protocol AuthorizationBuilder {
    func build() -> UIViewController
}

protocol AuthorizationViewModel {
    func confirm(name: String?, surname: String?, city: String?, phoneNumber: String?)
    func skip()
}
