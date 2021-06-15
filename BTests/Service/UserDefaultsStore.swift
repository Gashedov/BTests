//
//  UserDefaultsStore.swift
//  BTests
//
//  Created by Artem Gorshkov on 9.06.21.
//

import Foundation

class UserDefaultsStore {
    struct Key {
        static let userName = "userName"
        static let userSurname = "userSurname"
        static let userCity = "userCity"
        static let userPhoneNumber = "userPhoneNumber"
        static let appDidRunBefore = "appDidRunBefore"
    }

    static let shared = UserDefaultsStore()

    var appDidRunBefore: Bool {
        get {
            UserDefaults.standard.bool(forKey: Key.appDidRunBefore)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.appDidRunBefore)
        }
    }

    var userName: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.userName)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.userName)
        }
    }

    var userSurname: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.userSurname)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.userSurname)
        }
    }

    var userCity: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.userCity)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.userCity)
        }
    }

    var userPhoneNumber: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.userPhoneNumber)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.userPhoneNumber)
        }
    }
}
