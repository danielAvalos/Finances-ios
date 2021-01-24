//
//  ListViewController+UITableViewDelegate.swift
//  Finances
//
//  Created by DESARROLLO on 24/01/21.
//

import UIKit

// MARK: - UITableViewDelegate
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
