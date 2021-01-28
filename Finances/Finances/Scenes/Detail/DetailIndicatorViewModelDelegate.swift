//
//  DetailIndicatorViewModelDelegate.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Charts

protocol DetailIndicatorViewModelDelegate: ViewModelDelegate {
    func showIndicatorInfo(indicator: Indicator)
    func showError(error: Error)
}
