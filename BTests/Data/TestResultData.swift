//
//  TestResultData.swift
//  BTests
//
//  Created by Artem Gorshkov on 22.06.21.
//

import Foundation

public struct TestResultData: Codable {
    let answersIds: [Int]
    let student: StudentData
    let testId: Int
}
