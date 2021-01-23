//
//  ListViewModelProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

protocol ListViewModelProtocol {
    var delegate: ListViewModelDelegate? { get set }
    var state: ViewModelState<ConnectionStatus> { get set }
    func prepareList()
    func filterContent(forQuery: String?)
    func logout()
    func getUserSession() -> SessionModel?
}

protocol ListViewModelEntityProtocol {
    var indicators: [Indicator] { get }
}
