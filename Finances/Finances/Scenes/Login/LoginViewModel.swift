//
//  LoginViewModel.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import Foundation

// MARK: - LoginViewModelEntityProtocol
final class LoginViewModel: LoginViewModelEntityProtocol {
    weak var delegate: LoginViewModelDelegate?
    var userName: String?
    var password: String?
}

// MARK: - LoginViewModelProtocol
extension LoginViewModel: LoginViewModelProtocol {

    func login() {
        guard let username = userName,
              !username.isEmpty else {
            delegate?.loginDidFailWithError(Error(code: .notUserName))
            return
        }
        guard let password = password,
              !password.isEmpty else {
            delegate?.loginDidFailWithError(Error(code: .notPassword))
            return
        }
        guard UserCDManager.existsUser(username: username,
                                       password: password) else {
            delegate?.loginDidFailWithError(Error(code: .userInvalid))
            return
        }
        let session = SessionModel(isLogged: true,
                                   username: username,
                                   currentConnection: Date(),
                                   lastConnection: nil)
        _ = SessionCDManager.saveOrUpdate(session: session)
        delegate?.loginDidComplete()
    }
}
