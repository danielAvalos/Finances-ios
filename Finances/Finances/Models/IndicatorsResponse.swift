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
    var uDeF: Indicator?
    var ivp: Indicator?
    var dolar: Indicator?
    var dolarIntercambio: Indicator?
    var euro: Indicator?
    var ipc: Indicator?
    var utm: Indicator?
    var imacec: Indicator?
    var tpm: Indicator?
    var libraCobre: Indicator?
    var tasaDesempleo: Indicator?
    var bitCoin: Indicator?
}

extension IndicatorsResponse: Codable {

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
        case bitCoin = "bitCoin"
    }
}
