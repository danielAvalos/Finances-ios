//
//  UIView+Shadow.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

extension UIView {

    func genericShadow() {
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.color(named: .grayLight)?.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.3
    }
}
