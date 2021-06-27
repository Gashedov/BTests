//
//  TestResponseData.swift
//  BTests
//
//  Created by Artem Gorshkov on 24.06.21.
//

import Foundation

struct TestResponseData: Decodable {
    let faculty: FacultyData?
    let specialty: SpecialtyData?
    let otherResult: String?
}
