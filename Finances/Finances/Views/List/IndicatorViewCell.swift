//
//  IndicatorViewCell.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

class IndicatorViewCell: UITableViewCell, NibLoadableView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension IndicatorViewCell {
    func configure(with viewModel: Indicator) {
        textLabel?.text = viewModel.name
        if let value = viewModel.value {
            detailTextLabel?.text = "\(value)"
        }
    }
}
