//
//  APIManager.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Alamofire

enum APIRouter: URLRequestConvertible {

    case getIndicators

    var method: HTTPMethod {
        switch self {
        case .getIndicators:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getIndicators:
            return "/api"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getIndicators:
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
        let url = try Config.apiBaseUrl.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}

struct Config {
    static let apiBaseUrl = "https://www.mindicador.cl"
}
