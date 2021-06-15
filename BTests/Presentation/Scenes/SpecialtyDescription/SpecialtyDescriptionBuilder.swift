//
//  SpecialtyDescriptionBuilder.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import Foundation

import UIKit

class SpecialtyDescriptionBuilderImpl: SpecialtyDescriptionBuilder {
    func build() -> UIViewController {
        let view = SpecialtyDescriptionView()

        let viewModel = SpecialtyDescriptionViewModelImpl()
        view.viewModel = viewModel

        return view
    }
}
