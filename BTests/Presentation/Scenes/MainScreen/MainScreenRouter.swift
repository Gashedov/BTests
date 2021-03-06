//
//  MainScreenRouter.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

class MainScreenRouterImpl: MainScreenRouter {
    private let view: UIViewController

    init(view: UIViewController) {
        self.view = view
    }
    
    func pushFacultyDescription(for faculty: FacultyData) {
        let facultyDescriptionView = FacultyDescriptionBuilderImpl()
            .build(withFaculty: faculty)
        view.navigationController?.pushViewController(facultyDescriptionView, animated: true)
    }

    func pushTestList() {
        let testListView = TestListBuilderImpl().build()
        view.navigationController?.pushViewController(testListView, animated: true)
    }
}
