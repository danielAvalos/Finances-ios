//
//  ListConfigurator.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

struct ListConfigurator {

    static func configure(_ viewController: ListViewController) {
        let service = IndicatorsService()
        let viewModel = ListViewModel(service: service)
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
    }
}
