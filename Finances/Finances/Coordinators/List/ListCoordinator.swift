//
//  ListCoordinator.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

final class ListCoordinator: ListCoordinatorProtocol {

    weak var viewController: ListViewController?

    func navigateToDetail(_ indicator: Indicator) {
        guard let detailIndicatorViewController = LoadUI.load(type: DetailIndicatorViewController.self,
                                                   from: XibName.detailIndicator),
              let navigationController = viewController?.navigationController else {
            return
        }
        detailIndicatorViewController.viewModel?.indicator = indicator
        navigationController.pushViewController(detailIndicatorViewController, animated: true)
    }
}
