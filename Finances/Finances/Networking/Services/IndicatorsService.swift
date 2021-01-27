//
//  IndicatorService.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

final class IndicatorsService: IndicatorServiceProtocol {

    func getHistoricalIndicatorBy(type: IndicatorType, date: String, completionHandler: @escaping (IndicatorResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getIndicators,
                        completionHandler: completionHandler)
    }

    func getHistoricalIndicatorByType(_ type: IndicatorType, completionHandler: @escaping (IndicatorResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getIndicators,
                        completionHandler: completionHandler)
    }

    func getIndicatorsList(completionHandler: @escaping (IndicatorsResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getIndicators,
                        completionHandler: completionHandler)
    }
}
