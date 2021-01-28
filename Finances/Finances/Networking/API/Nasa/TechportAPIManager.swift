//
//  NasaAPIManager.swift
//  Finances
//
//  Created by DESARROLLO on 28/01/21.
//

import Alamofire

enum TechportAPIRouter: URLRequestConvertible {

    case getProjects
    case getProjectById(_ id: Int)
    case getProjectsBy(date: String)

    var method: HTTPMethod {
        switch self {
        case .getProjects,
             .getProjectById,
             .getProjectsBy:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getProjects:
            return "/techport/api/projects"
        case let .getProjectById(id):
            return "/techport/api/projects/\(id)"
        case let .getProjectsBy(date): //yyyy-MM-dd
            //&api_key=b9MhlKl7rH3JhsrOwl4NenNLKfDRzm0ydJH4cOKZ
            return "/techport/api/projects?updatedSince=\(date)"
        }
    }

    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json; charset=utf-8"
        headers["Authorization"] = "Token b9MhlKl7rH3JhsrOwl4NenNLKfDRzm0ydJH4cOKZ"
        return headers
    }

    var parameters: Parameters? {
        switch self {
        case .getProjects,
             .getProjectById,
             .getProjectsBy:
            return nil
        }
    }

    var encoding: ParameterEncoding {
        switch method {
        default:
            return JSONEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try ApiBase.nasa.rawValue.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
