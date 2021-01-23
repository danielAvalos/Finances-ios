//
//  DetailIndicatorViewModelProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

protocol DetailIndicatorViewModelProtocol {
    var delegate: DetailIndicatorViewModelDelegate? { get set }
    func prepareDetail()
}

protocol DetailIndicatorViewModelEntityProtocol {
    var indicator: Indicator? { get set }
}
