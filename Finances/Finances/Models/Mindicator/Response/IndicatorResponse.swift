//
//  IndicatorResponse.swift
//  Finances
//
//  Created by DESARROLLO on 27/01/21.
//

struct IndicatorResponse: Codable {
    let version: String?
    let author: String?
    let code: String?
    let name: String?
    let unitOfMeasurement: String?
    let serie: [Serie]?

    struct Serie: Codable {
        let date: String?
        let value: Double?
    }
}

extension IndicatorResponse {

    enum CodingKeys: String, CodingKey {
        case version = "version"
        case author = "autor"
        case code = "codigo"
        case name = "nombre"
        case unitOfMeasurement = "unidad_medida"
        case serie
    }
}

extension IndicatorResponse.Serie {
    enum CodingKeys: String, CodingKey {
        case date = "fecha"
        case value = "valor"
    }
}
