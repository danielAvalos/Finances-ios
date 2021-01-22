//
//  ListCoordinatorProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

protocol ListCoordinatorProtocol {
    var delegate: AppCoordinatorProtocol? { get set }
    func navigateToDetail(_ indicator: Indicator)
    func logout()
}
