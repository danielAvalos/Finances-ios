//
//  LoginViewModelDelegate.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

protocol LoginViewModelDelegate: ViewModelDelegate {
    func loginDidComplete()
    func loginDidFailWithError(_ error: Error)
}
