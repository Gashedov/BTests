//
//  FacultyData.swift
//  BTests
//
//  Created by Artem Gorshkov on 9.06.21.
//

import Foundation

struct FacultyData: Decodable {
    let campus: String
    let facultyRating: String
    let hostelRating: String
    let id: Int
    let information: String
    let name: String
    let fullName: String
    let studentAssetRating: String
    let studyRating: String

    enum CodingKeys: String, CodingKey {
        case fullName = "shortInformation"
        case campus
        case facultyRating
        case hostelRating
        case id
        case information
        case name
        case studentAssetRating
        case studyRating
    }
}
