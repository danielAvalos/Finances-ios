//
//  HistoricalValuesViewModelDelegate.swift
//  Finances
//
//  Created by DESARROLLO on 27/01/21.
//

import Charts

protocol HistoricalValuesViewModelDelegate: ViewModelDelegate {
    func showHistoricalIndicator(data: ChartData)
    func showError(error: Error)
}
