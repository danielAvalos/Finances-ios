//
//  LoginCoordinatorProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

protocol LoginCoordinatorProtocol {
    var delegate: AppCoordinatorProtocol? { get set }
    func navigateToList()
}
