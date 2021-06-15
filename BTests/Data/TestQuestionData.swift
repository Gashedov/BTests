//
//  TestQuestionData.swift
//  BTests
//
//  Created by Artem Gorshkov on 14.06.21.
//

import Foundation

struct TestQuestionData: Decodable {
    let id: Int
    let answers: [TestAnswerData]
    let questionText: String
    let questionType: Int

    enum CodingKeys: String, CodingKey {
        case id
        case answers
        case questionText
        case questionType = "questype"
    }
}
