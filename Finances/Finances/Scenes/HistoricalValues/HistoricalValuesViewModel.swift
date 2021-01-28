//
//  HistoricalValuesViewModel.swift
//  Finances
//
//  Created by DESARROLLO on 27/01/21.
//

import Charts

// MARK: - HistoricalValuesViewModelEntityProtocol
final class HistoricalValuesViewModel: HistoricalValuesViewModelEntityProtocol {

    weak var delegate: HistoricalValuesViewModelDelegate?
    var code: String?
    let service: IndicatorServiceProtocol

    init(service: IndicatorServiceProtocol) {
        self.service = service
    }
}

extension HistoricalValuesViewModel: HistoricalValuesViewModelProtocol {

    func prepareHistorical() {
        guard let code = code else {
            delegate?.showError(error: Error(code: .dataNotFound))
            return
        }
        service.getHistoricalIndicatorByType(code) { [weak self] (response, error) in
            if error == nil {
                guard let response = response,
                      let serie = response.serie else {
                    return
                }
                var dataEntry: [ChartDataEntry] = serie.compactMap {
                    guard let date = $0.date?.getDate()?.string(format: "MM.dd"),
                          let dateDouble = Double(date),
                          let value = $0.value else {
                        return nil
                    }
                    return ChartDataEntry(x: dateDouble, y: value)
                }
                dataEntry = dataEntry.sorted { (entryOne, entryTwo) -> Bool in
                    return entryOne.x < entryTwo.x
                }
                let lineChartDataSet = LineChartDataSet.init(entries: dataEntry, label: "Historico")
                let chartData = ChartData(dataSet: lineChartDataSet)
                self?.delegate?.showHistoricalIndicator(data: chartData)
            }
        }
    }
}
