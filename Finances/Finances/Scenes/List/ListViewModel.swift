//
//  ListViewModel.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

// MARK: - ListViewModelEntityProtocol
final class ListViewModel: ListViewModelEntityProtocol {

    weak var delegate: ListViewModelDelegate?
    var state: ViewModelState<ConnectionStatus> = .initial {
        didSet {
            delegate?.stateDidChange(state: state)
        }
    }
    private var unfilteredIndicators: [Indicator] = []
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
                    strongSelf.unfilteredIndicators = strongSelf.indicators
                    strongSelf.state = .ready(value: .online)
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
        guard let sessionActive = SessionCDManager.getSessionActive(),
              let username = sessionActive.username,
              let lastConnection = sessionActive.lastConnection else {
            return
        }
        _ = SessionCDManager.saveOrUpdate(username: username,
                                      lastConnection: lastConnection,
                                      isLogged: false)
        delegate?.logout()
    }
}

private extension ListViewModel { }
