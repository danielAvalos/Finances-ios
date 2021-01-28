//
//  ListViewModel.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import Foundation

// MARK: - ListViewModelEntityProtocol
final class ListViewModel: ListViewModelEntityProtocol {

    weak var delegate: ListViewModelDelegate?
    var state: ViewModelState<ConnectionStatus> = .initial {
        didSet {
            delegate?.stateDidChange(state: state)
        }
    }
    var unfilteredIndicators: [Indicator] = []
    var indicators: [Indicator] = []
    let service: IndicatorServiceProtocol

    init(service: IndicatorServiceProtocol) {
        self.service = service
    }
}

// MARK: - ListViewModelProtocol
extension ListViewModel: ListViewModelProtocol {
    func getUserSession() -> SessionModel? {
        return SessionCDManager.getSessionActive()
    }

    func prepareList() {
        state = .loading
        if ReachabilityManager.shared.isConnected {
            service.getIndicatorsList { [weak self] (response, error) in
                guard let strongSelf = self else {
                    return
                }
                guard let error = error else {
                    strongSelf.indicators = response?.indicators ?? []
                    if Locale.current.languageCode != "es" {
                        strongSelf.unfilteredIndicators = []
                        strongSelf.translateIndicators()
                    } else {
                        strongSelf.unfilteredIndicators = strongSelf.indicators
                        strongSelf.state = .ready(value: .online)
                    }
                    return
                }
                self?.state = .failed(error: error)
            }
        } else {
            guard indicators.isEmpty else {
                return
            }
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

    func logout() {
        guard let sessionActive = SessionCDManager.getSessionActive() else {
            return
        }
        _ = SessionCDManager.changeStatus(username: sessionActive.username,
                                          isLogged: false)
        delegate?.logout()
    }
}

private extension ListViewModel {

    func translateIndicators() {
        let dataToTranslate = self.indicators
        guard let next = dataToTranslate.first else {
            self.indicators = self.unfilteredIndicators
            self.state = .ready(value: .online)
            return
        }
        textToTranslate(model: next)
    }

    func textToTranslate(model: Indicator) {
        guard let name = model.name else {
            unfilteredIndicators.append(model)
            return
        }
        GoogleTranslateManager.translate(text: name) { [weak self] (textTranslated) in
            guard let strongSelf = self else {
                return
            }
            if let index = strongSelf.indicators.firstIndex(where: { $0.name == name }) {
                let indicator = strongSelf.indicators[index]
                let indicatorTranslated = Indicator(code: indicator.code,
                                                    name: textTranslated,
                                                    unitOfMeasurement: indicator.unitOfMeasurement,
                                                    date: indicator.date,
                                                    value: indicator.value)
                strongSelf.unfilteredIndicators.append(indicatorTranslated)
                strongSelf.indicators.remove(at: index)
            }
            strongSelf.translateIndicators()
        }
    }
}
