//
//  IndicatorServiceProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

protocol IndicatorServiceProtocol {

    func getHistoricalIndicatorBy(type: String, date: String, completionHandler: @escaping (IndicatorResponse?, Error?) -> Void)
    func getHistoricalIndicatorByType(_ type: String, completionHandler: @escaping (IndicatorResponse?, Error?) -> Void)
    func getIndicatorsList(completionHandler: @escaping (IndicatorsResponse?, Error?) -> Void)
}
