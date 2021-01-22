//
//  SessionModel.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

struct SessionModel {

    static let entityName: String = "Session"

    let username: String?
    let lastConnection: Date?
    let isLogged: Bool
}
