//
//  FacultyDescritionBuilder.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class FacultyDescriptionBuilderImpl: FacultyDescriptionBuilder {
    func build(withFaculty facultyData: FacultyData) -> UIViewController {
        let view = FacultyDescriptionView()

        let router = FacultyDescriptionRouterImpl(view: view)
        let viewModel = FacultyDescriptionViewModelImpl(
            router: router,
            facultyData: facultyData
        )
        view.viewModel = viewModel

        return view
    }
}

