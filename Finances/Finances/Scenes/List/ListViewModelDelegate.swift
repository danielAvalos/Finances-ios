//
//  ListViewModelDelegate.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

protocol ListViewModelDelegate: ViewModelDelegate {
    func stateDidChange(state: ViewModelState<ConnectionStatus>)
    func logout()
}
