//
//  ListViewModel.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

protocol ListViewModelProtocol {
    var delegate: ListViewModelDelegate? { get set }
    var state: ViewModelState<ConnectionStatus> { get set }
    func prepareList()
    func filterContent(forQuery: String?)
}

protocol ListViewModelEntityProtocol {
    
    var indicators: [Indicator] { get set }
    
}

// MARK: - LoginViewModelEntityProtocol
final class ListViewModel: ListViewModelEntityProtocol {

    weak var delegate: ListViewModelDelegate?
    var state: ViewModelState<ConnectionStatus> = .initial {
        didSet {
            delegate?.stateDidChange(previousState: oldValue)
        }
    }
    var indicators: [Indicator] = []
    let service: IndicatorsService

    init(service: IndicatorsService) {
        self.service = service
    }
}

// MARK: - ListViewModelProtocol
extension ListViewModel: ListViewModelProtocol {

    func prepareList() {
        service.getIndicatorsList { [weak self] (response, error) in
            guard let response = response else {
                return
            }
            self?.indicators = response.indicators
        }
    }

    func filterContent(forQuery: String?) {
    }
}

private extension ListViewModel { }
