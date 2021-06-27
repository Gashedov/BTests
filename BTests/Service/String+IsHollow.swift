//
//  String+IsHollow.swift
//  BTests
//
//  Created by Artem Gorshkov on 27.06.21.
//

import Foundation

extension String {
    var isHollow: Bool {
        get {
            return self.trimmingCharacters(in: .whitespaces).isEmpty
        }
    }
}
