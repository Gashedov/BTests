//
//  FacultyDescriptionViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 14.06.21.
//

import Moya

class FacultyDescriptionViewModelImpl: FacultyDescriptionViewModel {
    private let apiProvider = MoyaProvider<API>()
    private let router: FacultyDescriptionRouter

    private let facultyData: FacultyData
    var specialties: [Specialty] = []
    private var specialtiesData: [SpecialtyData] = []

    weak var delegate: FacultyDescriptionViewModelDelegate?

    init(
        router: FacultyDescriptionRouter,
        facultyData: FacultyData
    ) {
        self.facultyData = facultyData
        self.router = router
    }

    func fetchSpecialties() {
        let facultyId = String(facultyData.id)
        apiProvider.request(.specialties(ofFacultyWithId: facultyId)) { result in
            switch result {
            case .success(let responce):

                if let JSONString = String(data: responce.data, encoding: String.Encoding.utf8) {
                    print(JSONString)
                }

                guard let info = try? JSONDecoder().decode([SpecialtyData].self, from: responce.data) else {
                    return
                }

                self.specialtiesData = info
                self.specialties = info.map {
                    return Specialty(
                        facultyName: $0.facultyName,
                        firstSubjectName: $0.firstSubjectName,
                        information: $0.information,
                        name: $0.name,
                        passingScore: $0.passingScore,
                        secondSubjectName: $0.secondSubjectName,
                        thirdSubjectName: $0.thirdSubjectName
                    )
                }

                self.delegate?.specialtiesFetched()
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchFuculty() -> Faculty {
        Faculty(
            name: facultyData.name,
            fullName: facultyData.fullName,
            description: facultyData.information
        )
    }

    func openSpecialtyView(at index: Int) {
        guard index >= 0, index < specialtiesData.count else { return }
        let specialty = specialtiesData[index]
        router.pushSpecialtyDescription(with: specialty)
    }
}
