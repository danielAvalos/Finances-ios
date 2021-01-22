//
//  RequestService.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation
import Alamofire

final class Service {

    static func request<T: Decodable>(apiRouter: APIRouter, completionHandler: @escaping (T?, Error?) -> Void) {
        let request = AF.request(apiRouter)
        request.responseDecodable(of: T.self) { (response) in
            guard let httpURLResponse = response.response else {
                completionHandler(nil, Error(code: .errorServer, descriptionLocalizable: response.error?.errorDescription))
                return
            }
            switch httpURLResponse.statusCode {
            case 200, 204:
                completionHandler(response.value, nil)
            case 401:
                completionHandler(nil, Error(code: .notAuthorized))
            case 400:
                completionHandler(nil, Error(code: .badRequest))
            case 404:
                completionHandler(nil, Error(code: .requestNotFound))
            case 500:
                completionHandler(nil, Error(code: .errorServer))
            default:
                completionHandler(nil, Error(code: .unknown))
            }
        }
    }
}
