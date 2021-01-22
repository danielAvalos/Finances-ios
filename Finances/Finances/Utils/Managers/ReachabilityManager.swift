//
//  ReachabilityManager.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Reachability

struct ReachabilityManager {

    static let shared = ReachabilityManager()

    ///returns the current state of the connection
    var isConnected: Bool {
        do {
            let reachability = try Reachability()
            return reachability.connection != .unavailable
        } catch {
            print("Unable to start notifier")
        }
        return false
    }
}
