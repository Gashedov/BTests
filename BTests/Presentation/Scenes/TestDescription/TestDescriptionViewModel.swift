//
//  TestDescriptionViewModel.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import Foundation

class TestDescriptionViewModelImpl: TestDescriptionViewModel {
    private let router: TestDescriptionRouter
    private let testData: TestData

    let test: Test

    init(
        router: TestDescriptionRouter,
        testData: TestData
    ) {
        self.router = router
        self.testData = testData
        let testQuestions = testData.questions.map { question -> TestQuestion in
            let answers = question.answers.map {
                return TestAnswer(title: $0.answerText)
            }
            return TestQuestion(answers: answers, description: question.questionText, type: question.questionType)
        }
        self.test = Test(questions: testQuestions, testName: testData.testType)
    }

    func openTest() {
        router.pushTest(with: testData)
    }
}
