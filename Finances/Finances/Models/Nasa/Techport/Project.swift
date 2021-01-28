//
//  Project.swift
//  Finances
//
//  Created by DESARROLLO on 28/01/21.
//

struct Project: ProjectProtocol {

    let id: Int?
    let lastUpdated: String?
}

extension Project: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case lastUpdated
    }
}
