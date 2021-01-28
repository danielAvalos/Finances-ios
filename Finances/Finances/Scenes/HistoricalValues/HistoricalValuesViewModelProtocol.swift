//
//  HistoricalValuesViewModelProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 27/01/21.
//

protocol HistoricalValuesViewModelProtocol {
    var delegate: HistoricalValuesViewModelDelegate? { get set }
    func prepareHistorical()
}

protocol HistoricalValuesViewModelEntityProtocol {
    var code: String? { get set }
}
