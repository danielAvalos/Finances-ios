//
//  DetailCoordinator.swift
//  Finances
//
//  Created by DESARROLLO on 27/01/21.
//

import UIKit

final class DetailIndicatorCoordinator: DetailIndicatorCoordinatorProtocol {

    weak var viewController: DetailIndicatorViewController?

    func navigateToHistorical(code: String) {
        guard let historicalValuesViewController = LoadUI.load(type: HistoricalValuesViewController.self,
                                                               from: XibName.historicalValues),
              let navigationController = viewController?.navigationController else {
            return
        }
        historicalValuesViewController.viewModel?.code = code
        navigationController.pushViewController(historicalValuesViewController, animated: true)
    }
}
