//
//  Indicator.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

struct Indicator {

    let code: String?
    let name: String?
    var unitOfMeasurement: String?
    var date: String?
    var value: Double?
}

extension Indicator: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "codigo"
        case name = "nombre"
        case unitOfMeasurement = "unidad_medida"
        case date = "fecha"
        case value = "valor"
    }
}

extension Indicator: Equatable {
    static func == (lhs: Indicator, rhs: Indicator) -> Bool {
        lhs.code == rhs.code
    }
}
