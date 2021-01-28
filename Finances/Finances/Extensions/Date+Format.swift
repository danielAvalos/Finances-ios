//
//  Date+Format.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

extension Date {

    func string(_ dateStyle: DateFormatter.Style, _ timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        let dateWithFormat = formatter.string(from: self)
        return "\(dateWithFormat)"
    }

    func string(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
