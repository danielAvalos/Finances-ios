//
//  TechportServiceProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 28/01/21.
//

protocol TechportServiceProtocol {
    func getProjectById(_ id: Int, completionHandler: @escaping (ProjectDetailResponse?, Error?) -> Void)
    func getProjects(completionHandler: @escaping (ProjectsResponse?, Error?) -> Void)
    func getProjectsBy(date: String, completionHandler: @escaping (ProjectsResponse?, Error?) -> Void)
}
