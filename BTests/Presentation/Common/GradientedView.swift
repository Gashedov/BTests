//
//  GradientedView.swift
//  BTests
//
//  Created by Artem Gorshkov on 30.05.21.
//

import UIKit

class GradientedView: UIView {
    func applyGradient(startPoint: CGPoint, endPoint: CGPoint, colorArray: [UIColor?]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.compactMap({ $0?.cgColor })
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
