//
//  DetailIndicatorViewController.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

final class DetailIndicatorViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet private weak var codeLabel: UILabel!
    @IBOutlet private weak var unitOfMeasurementLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!

    var viewModel: (DetailIndicatorViewModelProtocol & DetailIndicatorViewModelEntityProtocol)?

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.prepareDetail()
    }
}

// MARK: - DetailIndicatorViewModelDelegate
extension DetailIndicatorViewController: DetailIndicatorViewModelDelegate {
    func showError(error: Error) {
        showAlert(title: error.title, message: error.description )
    }

    func showIndicatorInfo(indicator: Indicator) {
        setupNavigation()
        if let code = indicator.code {
            codeLabel.text = "Codigo: \(code)"
        }
        if let date = indicator.date {
            dateLabel.text = "Fecha: \(date)"
        }
        if let value = indicator.value {
            valueLabel.text = "Valor: \(value)"
        }
        if let unitOfMeasurement = indicator.unitOfMeasurement {
            unitOfMeasurementLabel.text = "Unidad de medida: \(unitOfMeasurement)"
        }
    }
}

// MARK: - Private functions
private extension DetailIndicatorViewController {

    func setup() {
        DetailIndicatorConfigurator.configure(self)
    }

    func setupNavigation() {
        navigationItem.title = viewModel?.indicator?.name
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
