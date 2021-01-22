//
//  LoginCoordinator.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

final class LoginCoordinator: LoginCoordinatorProtocol {

    weak var viewController: LoginViewController?
    weak var delegate: AppCoordinatorProtocol?

    func navigateToList() {
        delegate?.start()
    }
}
