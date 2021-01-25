//
//  String+Format.swift
//  Finances
//
//  Created by DESARROLLO on 25/01/21.
//

import Foundation

extension String {

    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
}
