//
//  ListViewModel.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

protocol ListViewModelProtocol {
    var delegate: ListViewModelDelegate? { get set }
    func prepareList()
    func filterContent(forQuery: String?)
}

protocol ListViewModelEntityProtocol {
}

// MARK: - LoginViewModelEntityProtocol
final class ListViewModel: ListViewModelEntityProtocol {
    weak var delegate: ListViewModelDelegate?
}

// MARK: - ListViewModelProtocol
extension ListViewModel: ListViewModelProtocol {

    func prepareList() {
    }

    func filterContent(forQuery: String?) {
    }
}
