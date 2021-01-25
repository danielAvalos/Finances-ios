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
            return MessagesLocalizable.notConnectionMessage.rawValue.localized
        case .unknown, .badRequest, .requestNotFound:
            return MessagesLocalizable.unknownMessage.rawValue.localized
        case .errorServer:
            return MessagesLocalizable.errorServerMessage.rawValue.localized
        case .notAuthorized:
            return MessagesLocalizable.notAuthorizedMessage.rawValue.localized
        case .other:
            return descriptionLocalizable?.localized ?? ""
        case .dataNotFound:
            return MessagesLocalizable.dataNotFoundMessage.rawValue.localized
        case .userRequired:
            return MessagesLocalizable.userRequiredTitle.rawValue.localized
        case .passwordRequired:
            return MessagesLocalizable.passwordRequiredMessage.rawValue.localized
        case .userInvalid:
            return MessagesLocalizable.userInvalidMessage.rawValue.localized
        }
    }

    var title: String {
        switch code {
        case .notConnection:
            return MessagesLocalizable.notConnectionTitle.rawValue.localized
        case .unknown:
            return MessagesLocalizable.unknownTitle.rawValue.localized
        case .badRequest:
            return MessagesLocalizable.badRequestTitle.rawValue.localized
        case .requestNotFound:
            return MessagesLocalizable.requestNotFoundTitle.rawValue.localized
        case .errorServer:
            return MessagesLocalizable.errorServerTitle.rawValue.localized
        case .notAuthorized:
            return MessagesLocalizable.notAuthorizedTitle.rawValue.localized
        case .other:
            return descriptionLocalizable ?? ""
        case .dataNotFound:
            return MessagesLocalizable.dataNotFoundTitle.rawValue.localized
        case .userRequired:
            return MessagesLocalizable.userRequiredTitle.rawValue.localized
        case .passwordRequired:
            return MessagesLocalizable.passwordRequiredTitle.rawValue.localized
        case .userInvalid:
            return MessagesLocalizable.userInvalidTitle.rawValue.localized
        }
    }

    var code: ErrorCode
    var descriptionLocalizable: String?
}

protocol ErrorRepresentable {
    var code: ErrorCode { get set }
}

enum ErrorCode: String {
    case notConnection
    case unknown
    case badRequest
    case notAuthorized
    case errorServer
    case requestNotFound
    case dataNotFound
    case other
    case userRequired
    case passwordRequired
    case userInvalid
}

extension Error: Equatable {
    static func == (lhs: Error, rhs: Error) -> Bool {
        lhs.code == rhs.code
    }
}
