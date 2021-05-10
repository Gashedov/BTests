//
//  UserDefaultsService.swift
//  BTests
//
//  Created by Artem Gorshkov on 10.05.21.
//

import Foundation

class UserDefaultsService {
    static var appDidRunBefore: Bool {
        get {
            UserDefaults.standard.bool(forKey: "appDidRunBefore")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "appDidRunBefore")
        }
    }
}
