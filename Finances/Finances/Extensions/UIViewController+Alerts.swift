//
//  UIViewController+Alerts.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, customActionTitle: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        guard presentedViewController == nil else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: customActionTitle ?? "Continue",
            style: .default,
            handler: handler
        )
        okAction.setValue(UIColor.color(named: .orange),
                          forKey: "titleTextColor")
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
