//
//  TiingoAPIManager.swift
//  Finances
//
//  Created by DESARROLLO on 28/01/21.
//

import Alamofire

enum TiingoAPIRouter: URLRequestConvertible {

    case getCrypto
    case getIEX
    case getForexBy(ticket: String)
    case getNews

    var method: HTTPMethod {
        switch self {
        case .getCrypto,
             .getForexBy,
             .getNews,
             .getIEX:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getCrypto:
            return "/api"
        case .getNews:
            return "/tiingo/news"
        case .getIEX:
            return "/iex"
        case let .getForexBy(ticket):
            return "/fx/\(ticket)/top"
        }
    }

    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json; charset=utf-8"
        headers["Authorization"] = "Token 2da8a271db1961218fe939c049e8fe1478f2b9a5"
        return headers
    }

    var parameters: Parameters? {
        switch self {
        case .getCrypto,
             .getNews,
             .getForexBy,
             .getIEX:
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
        let url = try ApiBase.tiingo.rawValue.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
