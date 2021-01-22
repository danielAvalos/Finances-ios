//
//  LoginViewModel.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import Foundation

protocol LoginViewModelProtocol {
    var delegate: LoginViewModelDelegate? { get set }
    func login()
}

protocol LoginViewModelEntityProtocol {
    var userName: String? { get set }
    var password: String? { get set }
}

final class LoginViewModel: LoginViewModelEntityProtocol {
    weak var delegate: LoginViewModelDelegate?
    var userName: String?
    var password: String?
}

extension LoginViewModel: LoginViewModelProtocol {

    func login() {
        guard let username = userName else {
            let error = NSError(domain: "debe ingresar el usuario", code: 0, userInfo: nil)
            delegate?.loginDidFailWithError(error)
            return
        }
        guard let password = password else {
            let error = NSError(domain: "debe ingresar la contraseña", code: 0, userInfo: nil)
            delegate?.loginDidFailWithError(error)
            return
        }
        guard UserCDManager.existsUser(username: username, password: password) else {
            let error = NSError(domain: "Usuario o contraseña incorrecto", code: 0, userInfo: nil)
            delegate?.loginDidFailWithError(error)
            return
        }
        delegate?.loginDidComplete()
    }
}
