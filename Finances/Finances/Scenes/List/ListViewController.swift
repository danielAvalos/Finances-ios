//
//  ListViewController.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit
import SkeletonView

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

// MARK: - ListViewModelDelegate
extension ListViewController: ListViewModelDelegate {

    func logout() {
        coordinator?.logout()
    }

    func stateDidChange(state: ViewModelState<ConnectionStatus>) {
        // Update UI
        switch state {
        case .initial, .loading:
            tableView.showAnimatedGradientSkeleton()
        case let .failed(error):
            displayGenericViewStatus(message: Message(error: error))
        case let .ready(connectionStatus):
            checkForEmptyContent(connectionStatus: connectionStatus)
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

// MARK: GenericMessageStatusViewDelegate
extension ListViewController: GenericMessageStatusViewDelegate {

    func didTapAction(action: Message.ButtonItem) {
        viewModel?.prepareList()
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
        tableView.hideSkeleton()
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

    func checkForEmptyContent(connectionStatus: ConnectionStatus) {
        tableView.refreshControl?.endRefreshing()
        let isEmpty = viewModel?.indicators.isEmpty == true
        tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(TimeInterval(0.5)))
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

    // MARK: - Actions
    @objc
    func refreshList(sender _: UIRefreshControl) {
        viewModel?.prepareList()
        refreshControl.endRefreshing()
    }
}
