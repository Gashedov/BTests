//
//  TestListViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 9.06.21.
//

import Moya

class TestListViewModelImpl: TestListViewModel {
    private let apiProvider = MoyaProvider<API>()
    private let router: TestListRouter

    init(router: TestListRouter) {
        self.router = router
    }

    var items: [Test] = []

    weak var delegate: TestListViewModelDelegate?

    func openTestDescription() {
        router.pushTestDescriotion()
    }

    func fetchItems() {
        apiProvider.request(.allTests) { result in
            switch result {
            case .success(let responce):
                
                if let JSONString = String(data: responce.data, encoding: String.Encoding.utf8) {
                    print(JSONString)
                }

                guard let info = try? JSONDecoder().decode([TestData].self, from: responce.data) else {
                    return
                }

                self.items = info.map {
                    let questions = $0.questions.map { question -> TestQuestion in
                        let answers = question.answers.map {
                            TestAnswer(title: $0.answerText)
                        }
                        return TestQuestion(
                            answers: answers,
                            description: question.questionText,
                            type: question.questionType
                        )
                    }
                    return Test(questions: questions, testName: $0.testType)
                }
                
                self.delegate?.itemsFetched()
            case .failure(let error):
                print(error)
            }
        }
    }
}

