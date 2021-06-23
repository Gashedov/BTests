//
//  MainScreenViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 9.06.21.
//

import Moya

class MainScreenViewModelImpl: MainScreenViewModel {
    // TODO: implement dependency injection
    private let apiProvider = MoyaProvider<API>()
    private let router: MainScreenRouter

    var items: [Faculty] = []
    private var facultiesData: [FacultyData] = []

    weak var delegate: MainScreenViewModelDelegate?

    init(router: MainScreenRouter) {
        self.router = router
    }

    func openTestList() {
        router.pushTestList()
    }

    func openFacultyDescription(forItemAt index: Int) {
        guard index >= 0, index < facultiesData.count else { return }
        let faculty = facultiesData[index]
        router.pushFacultyDescription(for: faculty)
    }

    func fetchItems() {
        apiProvider.request(.allFaculties) { result in
            switch result {
            case .success(let responce):
                guard let info = try? JSONDecoder().decode([FacultyData].self, from: responce.data) else {
                    return
                }

                if let JSONString = String(data: responce.data, encoding: String.Encoding.utf8) {
                    print(JSONString)
                }

                self.facultiesData = info
                self.items = info.map {
                    Faculty(name: $0.name, fullName: $0.fullName, description: $0.information)
                }
                self.delegate?.itemsFetched()
            case .failure(let error):
                print(error)
            }
        }
    }
}
