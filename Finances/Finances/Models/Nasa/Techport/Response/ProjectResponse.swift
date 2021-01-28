//
//  ProjectResponse.swift
//  Finances
//
//  Created by DESARROLLO on 28/01/21.
//

struct ProjectResponse: Codable {
    let totalCount: Int?
    let projects: [Project]?
}

extension ProjectResponse {

    enum CodingKeys: String, CodingKey {
        case totalCount
        case projects
    }
}
