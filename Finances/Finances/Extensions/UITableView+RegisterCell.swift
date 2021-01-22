//
//  UITableView+RegisterCell.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import UIKit

extension UITableView {

    /// Register a cell from a given nib file class type
    /// Both nib name and reuse identifier will have the same string.
    /// - Parameter cellTypes: The cells that will registered
    func registerCells(_ cellTypes: [UITableViewCell.Type]) {
        cellTypes.forEach({ self.register($0.nib, forCellReuseIdentifier: $0.reuseIdentifier) })
    }
}
