//
//  TestAnswerData.swift
//  BTests
//
//  Created by Artem Gorshkov on 14.06.21.
//

import Foundation

struct TestAnswerData: Decodable {
    let id: Int
    let answerText: String
    let membership: String
    let score: Float
}
