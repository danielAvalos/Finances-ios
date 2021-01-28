//
//  DetailIndicatorConfigurator.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

struct DetailIndicatorConfigurator {

    static func configure(_ viewController: DetailIndicatorViewController) {
        let viewModel = DetailIndicatorViewModel()
        let coordinator = DetailIndicatorCoordinator()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        coordinator.viewController = viewController
        viewModel.delegate = viewController
    }
}
