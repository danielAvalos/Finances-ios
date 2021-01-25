//
//  HeaderView.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

final class HeaderView: UIView, NibLoadableView {

    // MARK: - IB Outlets
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var lastConnectionLabel: UILabel!

    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension HeaderView {
    func configure(username: String, lastConnection: Date) {
        userNameLabel.text = "Hola \(username)!"
        lastConnectionLabel.text = "Último Ingreso: \(lastConnection.string(.full, .full))"
    }
}
