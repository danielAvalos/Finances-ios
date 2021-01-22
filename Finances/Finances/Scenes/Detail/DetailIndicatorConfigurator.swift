//
//  DetailIndicatorConfigurator.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

struct DetailIndicatorConfigurator {

    static func configure(_ viewController: DetailIndicatorViewController) {
        let viewModel = DetailIndicatorViewModel()
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
    }
}
