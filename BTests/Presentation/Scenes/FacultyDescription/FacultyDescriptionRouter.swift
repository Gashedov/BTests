//
//  FacultyDescriptionRouter.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class FacultyDescriptionRouterImpl: FacultyDescriptionRouter {
    private let view: UIViewController

    init(view: UIViewController) {
        self.view = view
    }

    func pushSpecialtyDescription(with specialty: SpecialtyData) {
        let specialtyView = SpecialtyDescriptionBuilderImpl().build(with: specialty)
        view.navigationController?.pushViewController(specialtyView, animated: true)
    }
}
