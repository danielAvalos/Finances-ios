//
//  ListViewController+UITableViewDataSource.swift
//  Finances
//
//  Created by DESARROLLO on 24/01/21.
//

import UIKit

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.indicators.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IndicatorViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.hideSkeleton()
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
