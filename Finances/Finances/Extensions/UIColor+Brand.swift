//
//  UIColor+Brand.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import UIKit

enum ColorsCustomized: String {
    case green =  "greenColor"
    case orange = "orangeColor"
    case yellow = "yellowColor"
    case red = "redColor"
    case black = "blackColor"
    case grayLight = "grayLightColor"
    case white = "whiteColor"
}

extension UIColor {

    static func color(named: ColorsCustomized) -> UIColor? {
        return UIColor(named: named.rawValue)
    }
}
