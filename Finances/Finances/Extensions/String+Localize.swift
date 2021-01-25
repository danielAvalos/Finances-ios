//
//  String+Localize.swift
//  Finances
//
//  Created by DESARROLLO on 25/01/21.
//

import Foundation

extension String {

    // Translators don't need comments, they're for the programmers
    var localized: String {
        return NSLocalizedString(self)
    }

    // If you want to be nice to the translators
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

    // Oh, those plurals
    func localized(with variable: CVarArg, comment: String = "") -> String {
        return String(format: localized(comment: comment), [variable])
    }

    static prefix func ~ (string: String) -> String {
        return string.localized
    }

}

private func NSLocalizedString(_ string: String) -> String {
    return NSLocalizedString(string, comment: "")
}
