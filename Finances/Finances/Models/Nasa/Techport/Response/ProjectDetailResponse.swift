//
//  ProjectDetailResponse.swift
//  Finances
//
//  Created by DESARROLLO on 28/01/21.
//

struct ProjectDetailResponse: Codable {
    let project: Project?
}

extension ProjectDetailResponse {

    enum CodingKeys: String, CodingKey {
        case project
    }
}
