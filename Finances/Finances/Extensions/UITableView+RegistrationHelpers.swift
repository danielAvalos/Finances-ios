//
//  UITableView+RegistrationHelpers.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: NibLoadableView {
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))

        register(nib, forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: NibLoadableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Cell with identifier: \(T.identifier) could not be dequeued!")
        }

        return cell
    }
}
