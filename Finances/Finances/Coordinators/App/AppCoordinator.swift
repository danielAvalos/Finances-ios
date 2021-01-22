//
//  AppCoordinator.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import UIKit

class AppCoordinator: AppCoordinatorProtocol {

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
        guard let loginViewController = LoadUI.load(type: LoginViewController.self,
                                                    from: XibName.login) else {
                                                        return
                                                    }
        loginViewController.coordinator?.delegate = self
        fadeTransitionOnRootViewController(controller: loginViewController)
    }

    func listController() {
        guard let listViewController = LoadUI.load(type: ListViewController.self,
                                                   from: XibName.list) else {
            rootLoginController()
            return
        }
        listViewController.coordinator?.delegate = self
        let navigationController = UINavigationController(rootViewController: listViewController)
        fadeTransitionOnRootViewController(controller: navigationController)
    }

    func fadeTransitionOnRootViewController(controller: UIViewController, duration: TimeInterval = 0.5, completion: ((_ newController: UIViewController?) -> Void)? = nil) {
        let currentController = window.rootViewController
        let frame = CGRect(x: 0, y: 0, width: controller.view.frame.width, height: controller.view.frame.height)
        let subView = UIView(frame: frame)
        window.backgroundColor = UIColor.black
        window.rootViewController = nil
        window.rootViewController = controller
        if let oldController = currentController {
            controller.willMove(toParent: nil)
            subView.addSubview(oldController.view)
            controller.view.addSubview(subView)
        }
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: { () -> Void in
            subView.alpha = 0
        }, completion: { [weak self] (_) -> Void in
            if let oldController = currentController {
                oldController.removeFromParent()
                controller.didMove(toParent: nil)
                subView.removeFromSuperview()
            }
            completion?(controller)
            self?.window.makeKeyAndVisible()
        })
    }
}
