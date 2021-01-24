//
//  ListViewController.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

final class ListViewController: UIViewController {

    var viewModel: (ListViewModelProtocol & ListViewModelEntityProtocol)?
    var coordinator: ListCoordinatorProtocol?
    var isopenSearch: Bool = false

    // MARK: - IB Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: Private Properties
    private lazy var genericStatusHeader: GenericMessageStatusView = GenericMessageStatusView.nibInstance
    private lazy var searchController: UISearchController = {
        UISearchController()
    }()
    private lazy var refreshControl: UIRefreshControl = { [unowned self] in
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refreshList(sender:)), for: .valueChanged)
        return refreshControl
    }()

    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel?.prepareList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
}

// MARK: - NavigationConfigureProtocol
extension ListViewController: NavigationConfigureProtocol {
    func didTapBarItem(sender: UIBarButtonItem) {
        switch sender.tag {
        case BarButtonItemTag.logout.rawValue:
            showConfirmLogout()
        default:
            break
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.indicators.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IndicatorViewCell = tableView.dequeueReusableCell(for: indexPath)
        if let indicator = viewModel?.indicators[indexPath.row] {
            cell.configure(with: indicator)
        }
        return cell
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 80
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView.nibInstance
        if let userSession = viewModel?.getUserSession(),
           let lastConnection = userSession.lastConnection {
            let username = userSession.username
            headerView.configure(username: username,
                                 lastConnection: lastConnection)
        }
        return headerView
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indicator = viewModel?.indicators[indexPath.row] {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [weak self] () -> Void in
                self?.navigationController?.navigationBar.prefersLargeTitles = false
            }, completion: { [weak self] (_) -> Void in
                self?.coordinator?.navigateToDetail(indicator)
            })
        }
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.prepareList()
    }
}

// MARK: - UISearchResultsUpdating
extension ListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard isopenSearch else {
            return
        }
        viewModel?.filterContent(forQuery: searchController.searchBar.text)
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchControllerDelegate {

    func willPresentSearchController(_ searchController: UISearchController) {
        isopenSearch = true
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        isopenSearch = false
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            navigationItem.title = "Indicadores"
            return
        }
        navigationItem.title = "Resultado de busqueda"
    }
}

extension ListViewController: ListViewModelDelegate {

    func logout() {
        coordinator?.logout()
    }

    func stateDidChange(state: ViewModelState<ConnectionStatus>) {
        // Update UI
        switch state {
        case .initial, .loading:
            break
        case let .failed(error):
            displayGenericViewStatus(message: Message(error: error))
        case let .ready(connectionStatus):
            checkForEmptyContent(connectionStatus: connectionStatus)
        }
    }

    private func checkForEmptyContent(connectionStatus: ConnectionStatus) {
        tableView.refreshControl?.endRefreshing()
        let isEmpty = viewModel?.indicators.isEmpty == true
        if connectionStatus == .offline, isEmpty {
            displayGenericViewStatus(message: Message(error: Error(code: .notConnection)))
        } else if isEmpty {
            displayGenericViewStatus(message: Message(error: Error(code: .dataNotFound)))
        } else {
            tableView.tableHeaderView = nil
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: GenericMessageStatusViewDelegate
extension ListViewController: GenericMessageStatusViewDelegate {

    func didTapAction(action: Message.ButtonItem) {
    }
}

private extension ListViewController {

    func setup() {
        ListConfigurator.configure(self)
    }

    func setupNavigation() {
        navigationItem.title = "Indicadores"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        showBarButtonItem(navigationItem: navigationItem, items: [.logout])
    }

    func setupTableView() {
        tableView.registerCells([IndicatorViewCell.self])
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
    }

    func displayGenericViewStatus(message: Message) {
        genericStatusHeader.setup(message)
        genericStatusHeader.delegate = self
        genericStatusHeader.autoresizingMask = .flexibleWidth
        genericStatusHeader.translatesAutoresizingMaskIntoConstraints = true
        genericStatusHeader.setNeedsLayout()
        genericStatusHeader.layoutIfNeeded()
        let size = CGSize(width: UIScreen.main.bounds.width, height: 0)
        genericStatusHeader.frame.size.height = genericStatusHeader.systemLayoutSizeFitting(size,
                                                                                      withHorizontalFittingPriority: UILayoutPriority.required,
                                                                                      verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
            .height
        tableView.tableHeaderView = genericStatusHeader
    }

    func showConfirmLogout() {
        showAlert(title: "Se cerrará la sesión",
                  message: "¿Estas seguro que quieres cerrar la sesión actual?",
                  customActionTitle: "SI",
                  handler: { [weak self] (_) in
                    self?.viewModel?.logout()
                  },
                  cancelActionTitle: "NO")
    }

    // MARK: - Actions
    @objc
    func refreshList(sender _: UIRefreshControl) {
        viewModel?.prepareList()
        refreshControl.endRefreshing()
    }
}
