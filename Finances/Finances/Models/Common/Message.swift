//
//  Message.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

struct Message {
    let title: String?
    let description: String?
    let action: ButtonItem?

    enum ButtonItem {
        case reloadData
        case notResult

        var title: String {
            switch self {
            case .reloadData:
                return MessagesLocalizable.retryText.rawValue.localized
            case .notResult:
                return MessagesLocalizable.dataNotFoundMessage.rawValue.localized
            }
        }
    }

    init(error: Error) {
        title = error.title
        description = error.description
        switch error.code {
        case .badRequest,
             .errorServer,
             .notConnection,
             .notAuthorized,
             .other,
             .unknown:
            action = .reloadData
        case .requestNotFound:
            action = .notResult
        default:
            action = nil
        }
    }
}
