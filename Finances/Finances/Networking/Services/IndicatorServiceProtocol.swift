//
//  IndicatorServiceProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

protocol IndicatorServiceProtocol {
    func getIndicatorsList(completionHandler: @escaping (IndicatorsResponse?, Error?) -> Void)
}
