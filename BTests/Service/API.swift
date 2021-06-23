//
//  API.swift
//  BTests
//
//  Created by Artem Gorshkov on 8.06.21.
//

import Moya

public enum API {
    case faculty(byId: String)
    case allFaculties

    case specialties(ofFacultyWithId: String)
    case specialty(byId: String)
    case allSpecialties

    case generalTest
    case allTests
    case test(byId: String)
    case testResults(_: TestResultData)
}

extension API: TargetType {

    public var baseURL: URL {
        return URL(string: "https://soaprojectkovalikhin.herokuapp.com/")!
    }

    public var path: String {
        switch self {
        case .faculty(byId: let id):
            return "faculty/\(id)"
        case .allFaculties:
            return "faculty/all"

        case .specialties(ofFacultyWithId: let facultyId):
            return "faculty/\(facultyId)/specialty"
        case .specialty(byId: let id):
            return "specialty/\(id)"
        case .allSpecialties:
            return "specialty/all"

        case .generalTest:
            return "test/general"
        case .allTests:
            return "test/all"
        case .test(byId: let id):
            return "test/\(id)"
        case .testResults:
            return "test/result/add"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .testResults:
            return .post
        case .allFaculties, .faculty, .allSpecialties, .allTests,
             .generalTest, .specialties, .specialty, .test:
            return .get
        }
    }

    public var sampleData: Data {
        let stubName: String
        switch self {
        default: stubName = ""
        }
        return stubbedResponse(stubName)
    }

    var parameters: [String: Any]? {
        switch self {
        case .testResults(let result):
            return result.dictionary
        default:
            return nil
        }
    }

    public var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
        return .requestPlain
    }

    public var headers: [String : String]? {
        let headers = ["Content-Type": "application/json"]
        return headers
    }

    public var validationType: ValidationType {
        return .successCodes
    }
}

// MARK: - Utils

private extension API {
    func stubbedResponse(_ name: String) -> Data {
        @objc class TestClass: NSObject { }

        let bundle = Bundle(for: TestClass.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            return Data()
        }
        return (try? Data(contentsOf: url)) ?? Data()
    }
}
