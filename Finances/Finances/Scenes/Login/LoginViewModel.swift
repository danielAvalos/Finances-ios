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
            let error = NSError(domain: "ingresa el usuario",
                                code: 0,
                                userInfo: nil)
            delegate?.loginDidFailWithError(error)
            return
        }
        guard let password = password else {
            let error = NSError(domain: "ingresa la contraseña",
                                code: 0,
                                userInfo: nil)
            delegate?.loginDidFailWithError(error)
            return
        }
        guard UserCDManager.existsUser(username: username,
                                       password: password) else {
            let error = NSError(domain: "Usuario o contraseña incorrecto",
                                code: 0,
                                userInfo: nil)
            delegate?.loginDidFailWithError(error)
            return
        }
        _ = SessionCDManager.saveOrUpdate(username: username,
                                      lastConnection: Date(),
                                      isLogged: true)
        delegate?.loginDidComplete()
    }
}
