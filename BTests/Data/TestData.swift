//
//  TestData.swift
//  BTests
//
//  Created by Artem Gorshkov on 14.06.21.
//

import Foundation

struct TestData: Decodable {
    let facultyId: Int?
    let id: Int
    let questions: [TestQuestionData]
    let testType: String
}
