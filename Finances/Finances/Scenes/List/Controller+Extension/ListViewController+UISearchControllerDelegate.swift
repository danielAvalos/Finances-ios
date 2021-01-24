//
//  ListViewController+UISearchControllerDelegate.swift
//  Finances
//
//  Created by DESARROLLO on 24/01/21.
//

import UIKit

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
