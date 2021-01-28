//
//  TechportService.swift
//  Finances
//
//  Created by DESARROLLO on 28/01/21.
//

final class TechportService: TechportServiceProtocol {

    func getProjectById(_ id: Int, completionHandler: @escaping (ProjectDetailResponse?, Error?) -> Void) {
        Service.request(apiRouter: TechportAPIRouter.getProjectById(id),
                        completionHandler: completionHandler)
    }

    func getProjects(completionHandler: @escaping (ProjectsResponse?, Error?) -> Void) {
        Service.request(apiRouter: TechportAPIRouter.getProjects,
                        completionHandler: completionHandler)
    }

    func getProjectsBy(date: String, completionHandler: @escaping (ProjectsResponse?, Error?) -> Void) {
        Service.request(apiRouter: TechportAPIRouter.getProjectsBy(date: date),
                        completionHandler: completionHandler)
    }
}
