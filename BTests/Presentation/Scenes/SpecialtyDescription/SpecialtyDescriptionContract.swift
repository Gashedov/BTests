//
//  SpecialtyDescriptionContract.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

protocol SpecialtyDescriptionBuilder {
    func build(with: SpecialtyData) -> UIViewController 
}

protocol SpecialtyDescriptionViewModel {
    func fetchSpecialty() -> Specialty
}
