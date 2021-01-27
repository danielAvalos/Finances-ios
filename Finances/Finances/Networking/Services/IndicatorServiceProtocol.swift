//
//  IndicatorServiceProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

protocol IndicatorServiceProtocol {

    func getHistoricalIndicatorBy(type: IndicatorType, date: String, completionHandler: @escaping (IndicatorResponse?, Error?) -> Void)
    func getHistoricalIndicatorByType(_ type: IndicatorType, completionHandler: @escaping (IndicatorResponse?, Error?) -> Void)
    func getIndicatorsList(completionHandler: @escaping (IndicatorsResponse?, Error?) -> Void)
}
