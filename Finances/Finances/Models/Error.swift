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
            return "Please check your internet connection and try again"
        case .unknown, .badRequest, .notFound:
            return "Something went wrong, please check your connection and try again"
        case .errorServer:
            return "Something went wrong, the service is not available, please try again later"
        case .notAuthorized:
            return "You are not authorized to use the service"
        case .other:
            return descriptionLocalizable ?? ""
        }
    }

    var title: String {
        switch code {
        case .notConnection:
            return "Not Connection"
        case .unknown:
            return "Unknow"
        case .badRequest:
            return "Bad Request"
        case .notFound:
            return "Not Found"
        case .errorServer:
            return "Error in Server"
        case .notAuthorized:
            return "Not authorized"
        case .other:
            return descriptionLocalizable ?? ""
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
    case notFound
    case other
}
