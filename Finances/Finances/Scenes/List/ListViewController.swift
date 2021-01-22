//
//  ListViewController.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

final class ListViewController: UIViewController {

    var viewModel: (ListViewModelProtocol & ListViewModelEntityProtocol)?
    var isopenSearch: Bool = false

    // MARK: - IB Outlets
    @IBOutlet private weak var tableView: UITableView!

    lazy var searchController: UISearchController = {
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

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension ListViewController: UITableViewDelegate {
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
    }

    func setupTableView() {
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Actions
    @objc
    func refreshList(sender _: UIRefreshControl) {
        refreshControl.endRefreshing()
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
    func stateDidChange(previousState: ViewModelState<String>) {
    }
}
