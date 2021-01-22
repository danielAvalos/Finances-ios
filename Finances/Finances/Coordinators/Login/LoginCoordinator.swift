//
//  LoginCoordinator.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

final class LoginCoordinator: LoginCoordinatorProtocol {

    weak var viewController: LoginViewController?

    func navigateToList() {
        guard let listViewController = LoadUI.load(type: ListViewController.self,
                                                   from: XibName.list) else {
            return
        }
        let navigationController = UINavigationController(rootViewController: listViewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController,
                                animated: true,
                                completion: nil)
    }
}
