//
//  MonitorListViewModelDelegate.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

class MonitorListViewModelDelegate: ListViewModelDelegate {

    public var stateDidChange: ((_ state: ViewModelState<ConnectionStatus>) -> Void)?
    public var logoutHandler: (() -> Void)?

    func stateDidChange(state: ViewModelState<ConnectionStatus>) {
        stateDidChange?(state)
    }

    func logout() {
        logoutHandler?()
    }
}
