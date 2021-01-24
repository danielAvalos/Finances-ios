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
        guard let username = userName else {
            delegate?.loginDidFailWithError(Error(code: .notUserName))
            return
        }
        guard let password = password else {
            delegate?.loginDidFailWithError(Error(code: .notPassword))
            return
        }
        guard UserCDManager.existsUser(username: username,
                                       password: password) else {
            delegate?.loginDidFailWithError(Error(code: .userInvalid))
            return
        }
        _ = SessionCDManager.saveOrUpdate(username: username,
                                      lastConnection: Date(),
                                      isLogged: true)
        delegate?.loginDidComplete()
    }
}
