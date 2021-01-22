//
//  LoadUI.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

enum XibName: String {
    case login = "Login"
    case list = "List"
}

class LoadUI {
    static func load<T>(type: T.Type, from nibName: XibName) -> T? {
        let view = Bundle.main.loadNibNamed(nibName.rawValue,
                                            owner: nil,
                                            options: nil)?.first
        return view as? T
    }
}
