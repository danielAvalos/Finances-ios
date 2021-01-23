//
//  Date+Format.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

extension Date {

    func getWithFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        let dateWithFormat = formatter.string(from: self)
        return "\(dateWithFormat)"
    }
}
