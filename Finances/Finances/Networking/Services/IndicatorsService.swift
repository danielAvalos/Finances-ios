//
//  IndicatorService.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

final class IndicatorsService: IndicatorServiceProtocol {

    func getHistoricalIndicatorBy(type: String, date: String, completionHandler: @escaping (IndicatorResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getHistoricalIndicatorBy(type: type, date: date),
                        completionHandler: completionHandler)
    }

    func getHistoricalIndicatorByType(_ type: String, completionHandler: @escaping (IndicatorResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getHistoricalIndicatorByType(type),
                        completionHandler: completionHandler)
    }

    func getIndicatorsList(completionHandler: @escaping (IndicatorsResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getIndicators,
                        completionHandler: completionHandler)
    }
}
