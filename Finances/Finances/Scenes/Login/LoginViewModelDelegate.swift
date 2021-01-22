//
//  LoginViewModelDelegate.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

protocol LoginViewModelDelegate: ViewModelDelegate {
    func loginDidComplete()
    func loginDidFailWithError(_ error: NSError)
}
