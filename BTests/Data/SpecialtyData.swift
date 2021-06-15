//
//  SpecialtyData.swift
//  BTests
//
//  Created by Artem Gorshkov on 14.06.21.
//

import Foundation

struct SpecialtyData: Decodable {
    let facultyName: String
    let firstSubjectName: String
    let id: Int
    let information: String
    let name: String
    let passingScore: String
    let secondSubjectName: String
    let thirdSubjectName: String
}
