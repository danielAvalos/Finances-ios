//
//  ListViewModelDelegate.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

protocol ListViewModelDelegate: ViewModelDelegate {
    func stateDidChange(previousState: ViewModelState<String>)
}
