//
//  AppCoordinator.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import UIKit

class AppCoordinator {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let loginViewController = LoadUI.load(type: LoginViewController.self,
                                              from: XibName.login)
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
}
