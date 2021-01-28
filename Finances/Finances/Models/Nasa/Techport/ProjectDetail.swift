//
//  ProjectDetail.swift
//  Finances
//
//  Created by DESARROLLO on 28/01/21.
//

struct ProjectDetail: ProjectProtocol {
    let id: Int?
    let lastUpdated: String?
    let title: String?
    let status: String?
    let startDate: String?
    let endDate: String?
    let description: String?
    let benefits: String?
    let technologyMaturityStart: String?
    let technologyMaturityCurrent: String?
    let technologyMaturityEnd: String?
    let responsibleProgram: String?
    let responsibleMissionDirectorateOrOffice: String?
    let leadOrganization: LeadOrganization?
    let workLocations: [String]?
    let programDirectors: [String]?
    let programManagers: [String]?
    let projectManagers: [String]?
    let principalInvestigators: [String]?
    let libraryItems: [LibraryItem]?
    let closeoutDocuments: [String]?
    let supportingOrganizations: [SupportingOrganizations]?
    let primaryTas: [PrimaryTas]?

    struct LeadOrganization: Codable {
        let name: String?
        let type: String?
        let acronym: String?
        let city: String?
        let state: String?
        let country: String?
    }

    struct LibraryItem: Codable {
        let id: Int?
        let title: String?
        let type: String?
        let description: String?
        let externalUrl: String?
        let publishedBy: String?
        let publishedDate: String?
        let files: [File]?
    }

    struct File: Codable {
        let id: Int?
        let url: String?
        let size: Int?
    }

    struct SupportingOrganizations: Codable {
        let name: String?
        let type: String?
        let acronym: String?
        let city: String?
        let state: String?
        let country: String?
    }

    struct PrimaryTas: Codable {
        let id: Int?
        let code: String?
        let title: String?
        let priority: String?
    }
}

extension ProjectDetail: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case lastUpdated
        case title
        case status
        case startDate
        case endDate
        case description
        case benefits
        case technologyMaturityStart
        case technologyMaturityCurrent
        case technologyMaturityEnd
        case responsibleProgram
        case responsibleMissionDirectorateOrOffice
        case leadOrganization
        case workLocations
        case programDirectors
        case programManagers
        case projectManagers
        case principalInvestigators
        case libraryItems
        case closeoutDocuments
        case supportingOrganizations
        case primaryTas
    }
}
