//
//  APIManager.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Alamofire

enum MindicatorAPIRouter: URLRequestConvertible {

    case getIndicators
    case getHistoricalIndicatorByType(_ type: String)
    case getHistoricalIndicatorBy(type: String, date: String)

    var method: HTTPMethod {
        switch self {
        case .getIndicators,
             .getHistoricalIndicatorBy,
             .getHistoricalIndicatorByType:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getIndicators:
            return "/api"
        case let .getHistoricalIndicatorByType(type):
            return "/api/\(type)"
        case let .getHistoricalIndicatorBy(type, date):
            return "/api/\(type)/\(date)"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getIndicators,
             .getHistoricalIndicatorBy,
             .getHistoricalIndicatorByType:
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
        let url = try ApiBase.mindicator.rawValue.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
