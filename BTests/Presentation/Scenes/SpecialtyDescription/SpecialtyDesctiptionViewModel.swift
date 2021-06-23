//
//  SpecialtyDesctiptionViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import Foundation

class SpecialtyDescriptionViewModelImpl: SpecialtyDescriptionViewModel {
    private let specialtyData: SpecialtyData

    init(specialty: SpecialtyData) {
        self.specialtyData = specialty
    }

    func fetchSpecialty() -> Specialty {
        return Specialty(
            facultyName: specialtyData.facultyName,
            firstSubjectName: specialtyData.firstSubjectName,
            information: specialtyData.information,
            name: specialtyData.name,
            passingScore: specialtyData.passingScore,
            secondSubjectName: specialtyData.secondSubjectName,
            thirdSubjectName: specialtyData.thirdSubjectName
        )
    }
}
