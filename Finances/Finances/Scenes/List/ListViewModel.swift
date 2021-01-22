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
    var indicators: [Indicator] { get }
}

// MARK: - LoginViewModelEntityProtocol
final class ListViewModel: ListViewModelEntityProtocol {

    weak var delegate: ListViewModelDelegate?
    var state: ViewModelState<ConnectionStatus> = .initial {
        didSet {
            delegate?.stateDidChange(state: state)
        }
    }
    private var unfilteredIndicators: [Indicator] = []
    var indicators: [Indicator] = []
    let service: IndicatorsService

    init(service: IndicatorsService) {
        self.service = service
    }
}

// MARK: - ListViewModelProtocol
extension ListViewModel: ListViewModelProtocol {

    func prepareList() {
        state = .loading
        if ReachabilityManager.shared.isConnected {
            service.getIndicatorsList { [weak self] (response, error) in
                guard let strongSelf = self else {
                    return
                }
                guard let error = error else {
                    strongSelf.indicators = response?.indicators ?? []
                    strongSelf.unfilteredIndicators = strongSelf.indicators
                    strongSelf.state = .ready(value: .online)
                    return
                }
                self?.state = .failed(error: error)
            }
        } else {
            state = .failed(error: Error(code: .notConnection))
        }
    }

    func filterContent(forQuery: String?) {
        state = .loading
        indicators = unfilteredIndicators
        let isConnectionStatus: ConnectionStatus =  ReachabilityManager.shared.isConnected ? .online : .offline
        guard let query = forQuery, !query.isEmpty else {
            state = .ready(value: isConnectionStatus)
            return
        }
        let searchResult = indicators.filter {
            $0.code?.lowercased().contains(query.lowercased()) == true
        }
        indicators = searchResult
        state = .ready(value: isConnectionStatus)
    }
}

private extension ListViewModel { }
