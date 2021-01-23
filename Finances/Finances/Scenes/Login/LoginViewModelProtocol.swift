//
//  LoginViewModelProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

protocol LoginViewModelProtocol {
    var delegate: LoginViewModelDelegate? { get set }
    func login()
}

protocol LoginViewModelEntityProtocol {
    var userName: String? { get set }
    var password: String? { get set }
}
