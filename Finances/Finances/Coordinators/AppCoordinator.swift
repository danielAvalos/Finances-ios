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
        if SessionCDManager.getSessionActive() != nil {
            listController()
        } else {
            rootLoginController()
        }
    }
}

private extension AppCoordinator {
    func rootLoginController() {
        let loginViewController = LoadUI.load(type: LoginViewController.self,
                                              from: XibName.login)
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }

    func listController() {
        guard let listViewController = LoadUI.load(type: ListViewController.self,
                                                   from: XibName.list) else {
            rootLoginController()
            return
        }
        let navigationController = UINavigationController(rootViewController: listViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
