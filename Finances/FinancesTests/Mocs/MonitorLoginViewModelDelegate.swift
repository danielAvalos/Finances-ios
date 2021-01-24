//
//  MonitorLoginViewModelDelegate.swift
//  FinancesTests
//
//  Created by DESARROLLO on 23/01/21.
//

final class MonitorLoginViewModelDelegate: LoginViewModelDelegate {

    public var loginDidCompleteHandler: (() -> Void)?
    public var loginDidFailWithError: ((_ error: Error) -> Void)?

    func loginDidComplete() {
        loginDidCompleteHandler?()
    }

    func loginDidFailWithError(_ error: Error) {
        loginDidFailWithError?(error)
    }
}
