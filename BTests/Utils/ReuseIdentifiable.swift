//
//  ReuseIdentifiable.swift
//  BTests
//
//  Created by Artem Gorshkov on 10.05.21.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseId: String { get }
}

extension ReuseIdentifiable where Self: UIView {
    static var reuseId: String {
        return String(describing: self)
    }
}

