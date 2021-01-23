//
//  UIView+Shadow.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

extension UIView {

    func genericShadow() {
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.color(named: .grayLight)?.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.3
    }
}
