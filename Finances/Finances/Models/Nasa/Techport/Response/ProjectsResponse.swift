//
//  ProjectsResponse.swift
//  Finances
//
//  Created by DESARROLLO on 28/01/21.
//

struct ProjectsResponse: Codable {
    let projects: ProjectResponse?
}

extension ProjectsResponse {

    enum CodingKeys: String, CodingKey {
        case projects
    }
}
