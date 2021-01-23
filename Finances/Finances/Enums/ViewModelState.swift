//
//  ViewModelProtocolState.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

enum ViewModelState<T> {
    case initial
    case loading
    case ready(value: T)
    case failed(error: Error)
}

extension ViewModelState: Equatable {
    static func == (lhs: ViewModelState<T>, rhs: ViewModelState<T>) -> Bool {
        return T.self == T.self
    }
}
