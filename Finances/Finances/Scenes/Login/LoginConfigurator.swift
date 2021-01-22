//
//  LoginConfigurator.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

struct LoginConfigurator {

    static func configure(_ viewController: LoginViewController) {
        let viewModel = LoginViewModel()
        let coordinator = LoginCoordinator()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        coordinator.viewController = viewController
        viewModel.delegate = viewController
    }
}
