//
//  ListConfigurator.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

struct ListConfigurator {

    static func configure(_ viewController: ListViewController) {
        let service = IndicatorsService()
        let viewModel = ListViewModel(service: service)
        let coordinator = ListCoordinator()
        coordinator.viewController = viewController
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
        viewController.coordinator = coordinator
    }
}
