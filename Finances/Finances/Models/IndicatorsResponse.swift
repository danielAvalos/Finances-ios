//
//  IndicatorsResponse.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

struct IndicatorsResponse {
    let version: String?
    let author: String?
    var date: String?
    var indicators: [Indicator] = []
}

extension IndicatorsResponse: Decodable {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        try loadValue(values, key: .uDeF)
        try loadValue(values, key: .ivp)
        try loadValue(values, key: .dolar)
        try loadValue(values, key: .dolarIntercambio)
        try loadValue(values, key: .euro)
        try loadValue(values, key: .ipc)
        try loadValue(values, key: .utm)
        try loadValue(values, key: .imacec)
        try loadValue(values, key: .tpm)
        try loadValue(values, key: .libraCobre)
        try loadValue(values, key: .tasaDesempleo)
        try loadValue(values, key: .bitcoin)
    }

    private mutating func loadValue(_ values: KeyedDecodingContainer<IndicatorsResponse.CodingKeys>, key: CodingKeys) throws {
        if let value = try values.decodeIfPresent(Indicator.self, forKey: key) {
            indicators.append(value)
        }
    }
}

extension IndicatorsResponse {

    enum CodingKeys: String, CodingKey {
        case version = "version"
        case author = "autor"
        case date = "fecha"
        case uDeF = "uf"
        case ivp = "ivp"
        case dolar = "dolar"
        case dolarIntercambio = "dolar_intercambio"
        case euro = "euro"
        case ipc = "ipc"
        case utm = "utm"
        case imacec = "imacec"
        case tpm = "tpm"
        case libraCobre = "libra_cobre"
        case tasaDesempleo = "tasa_desempleo"
        case bitcoin = "bitcoin"
    }
}
