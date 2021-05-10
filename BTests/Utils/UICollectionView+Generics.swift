//
//  UICollectionView+Generics.swift
//  BTests
//
//  Created by Artem Gorshkov on 10.05.21.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReuseIdentifiable {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseId)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReuseIdentifiable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseId) at indexPath: \(indexPath)")
        }
        return cell
    }
}
