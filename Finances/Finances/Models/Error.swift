//
//  Error.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

struct Error: ErrorRepresentable {

    var description: String {
        switch code {
        case .notConnection:
            return "Comprueba tu conexión a Internet y vuelve a intentarlo."
        case .unknown, .badRequest, .requestNotFound:
            return "Algo salió mal, verifique su conexión e intente nuevamente"
        case .errorServer:
            return "Algo salió mal, el servicio no está disponible, inténtelo de nuevo más tarde"
        case .notAuthorized:
            return "No está autorizado para utilizar el servicio"
        case .other:
            return descriptionLocalizable ?? ""
        case .dataNotFound:
            return "No se encontraron registros"
        case .notUserName:
            return "ingresa el usuario"
        case .notPassword:
            return "ingresa la contraseña"
        case .userInvalid:
            return "Usuario o contraseña incorrecto"
        }
    }

    var title: String {
        switch code {
        case .notConnection:
            return "Sin conexión"
        case .unknown:
            return "Error desconocido"
        case .badRequest:
            return "Solicitud incorrecta"
        case .requestNotFound:
            return "Petición no encontrada"
        case .errorServer:
            return "Error en el servidor"
        case .notAuthorized:
            return "No autorizado"
        case .other:
            return descriptionLocalizable ?? ""
        case .dataNotFound:
            return "No hay resultados"
        case .notUserName:
            return "Usuario es requerido"
        case .notPassword:
            return "Password es requerido"
        case .userInvalid:
            return "Error de credenciales"
        }
    }

    var code: ErrorCode
    var descriptionLocalizable: String?
}

protocol ErrorRepresentable {
    var code: ErrorCode { get set }
}

enum ErrorCode {
    case notConnection
    case unknown
    case badRequest
    case notAuthorized
    case errorServer
    case requestNotFound
    case dataNotFound
    case other
    case notUserName
    case notPassword
    case userInvalid
}

extension Error: Equatable {
    static func == (lhs: Error, rhs: Error) -> Bool {
        lhs.code == rhs.code
    }
}
