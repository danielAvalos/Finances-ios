//
//  UIViewController+Alerts.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, customActionTitle: String? = nil, handler: ((UIAlertAction) -> Void)? = nil, cancelActionTitle: String? = nil) {
        guard presentedViewController == nil else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(
            title: customActionTitle ?? "Continue",
            style: .default,
            handler: handler
        )
        confirmAction.setValue(UIColor.color(named: .green),
                               forKey: "titleTextColor")
        alertController.addAction(confirmAction)
        if cancelActionTitle != nil {
            let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        present(alertController, animated: true)
    }
}
