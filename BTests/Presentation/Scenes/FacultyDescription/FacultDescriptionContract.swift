//
//  FacultDescriptionContract.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import Foundation


import UIKit

protocol FacultyDescriptionRouter: AnyObject {
    func pushSpecialtyDescription()
}

protocol FacultyDescriptionBuilder {
    func build(withFaculty: FacultyData) -> UIViewController
}

protocol FacultyDescriptionViewModel {
    var specialties: [Specialty] { get }
    var delegate: FacultyDescriptionViewModelDelegate? { get set }

    func fetchSpecialties()
    func fetchFuculty() -> Faculty
    func openSpecialtyView()
}

protocol FacultyDescriptionViewModelDelegate: AnyObject {
    func specialtiesFetched()
}
