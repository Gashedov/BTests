//
//  AuthorizationViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 14.06.21.
//

import Foundation

class AuthorizationViewModelImpl: AuthorizationViewModel {
    private let router: AuthorizationRouter

    init(router: AuthorizationRouter) {
        self.router = router
    }

    func confirm(name: String?, surname: String?, city: String?, phoneNumber: String?) {
        let userDefaults = UserDefaultsStore.shared
        userDefaults.userName = name
        userDefaults.userSurname = surname
        userDefaults.userCity = city
        userDefaults.userPhoneNumber = phoneNumber
        router.presentMainScreen()
    }

    func skip() {
        router.presentMainScreen()
    }
}
