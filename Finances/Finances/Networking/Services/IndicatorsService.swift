//
//  IndicatorService.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

import Alamofire

final class IndicatorsService {

    func getIndicatorsList(completionHandler: @escaping (IndicatorsResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getIndicators,
                        completionHandler: completionHandler)
    }
}
