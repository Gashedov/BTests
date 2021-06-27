//
//  TestViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import Moya

class TestViewModelImpl: TestViewModel {
    private let apiProvider = MoyaProvider<API>()
    private let router: TestRouter

    private let testData: TestData
    private var answers: [TestAnswerData] = []

    var items: [TestQuestion]

    var delegate: TestViewModelDelegate?

    init(
        router: TestRouter,
        testData: TestData
    ) {
        self.router = router
        self.testData = testData
        self.items = testData.questions.map { question -> TestQuestion in
            let answers = question.answers.map {
                return TestAnswer(title: $0.answerText)
            }
            return TestQuestion(
                answers: answers,
                description: question.questionText,
                type: question.questionType
            )
        }
    }

    func openTestResults(with data: TestResponseData) {
        router.pushTestResult(with: data)
    }

    func backToMenu() {
        router.popToMainScreen()
    }

    func completeTest() {
        let studentData = StudentData(
            city: UserDefaultsStore.shared.userCity ?? "",
            id: 0,
            name: UserDefaultsStore.shared.userName ?? "",
            surname: UserDefaultsStore.shared.userSurname ?? "",
            telephone: UserDefaultsStore.shared.userPhoneNumber ?? ""
        )

        let answersId = answers.map { $0.id }

        let testResultData = TestResultData(
            answersIds: answersId,
            student: studentData,
            testId: testData.id
        )

        apiProvider.request(.testResults(testResultData)) { result in
            switch result {
            case .success(let responce):
                if let JSONString = String(data: responce.data, encoding: .utf8) {
                    print(JSONString)
                }
                
                guard let info = try? JSONDecoder().decode(TestResponseData.self, from: responce.data) else {
                    return
                }

                self.openTestResults(with: info)

            case .failure(let error):
                print(error)
                self.backToMenu()
            }
        }
    }


    func addAnswer(withNumber answerNumber: Int, andQuestionNumber questionNumber: Int) {
        guard questionNumber >= 0, questionNumber < testData.questions.count else { return }
        let questionData = testData.questions[questionNumber]

        guard answerNumber >= 0, answerNumber < questionData.answers.count else { return }
        let answer = questionData.answers[answerNumber]

        items[questionNumber].answers[answerNumber].isSelected = true
        answers.append(answer)
    }
}
