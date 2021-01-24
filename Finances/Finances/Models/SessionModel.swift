//
//  SessionModel.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

struct SessionModel {

    let isLogged: Bool
    let username: String
    let currentConnection: Date
    let lastConnection: Date?
}

enum SessionEntity: String {
    case entityName = "Session"
    case isLogged
    case username
    case currentConnection
    case lastConnection
}
