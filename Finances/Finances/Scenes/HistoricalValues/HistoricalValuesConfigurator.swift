//
//  HistoricalValuesConfigurator.swift
//  Finances
//
//  Created by DESARROLLO on 27/01/21.
//

struct HistoricalValuesConfigurator {

    static func configure(_ viewController: HistoricalValuesViewController) {
        let service = IndicatorsService()
        let viewModel = HistoricalValuesViewModel(service: service)
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
    }
}
