//
//  DetailIndicatorViewController.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

final class DetailIndicatorViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet private weak var codeView: DetailIndicatorFieldView!
    @IBOutlet private weak var unitOfMeasurementView: DetailIndicatorFieldView!
    @IBOutlet private weak var dateView: DetailIndicatorFieldView!
    @IBOutlet private weak var valueView: DetailIndicatorFieldView!

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
        codeView.setValue(value: indicator.code)
        dateView.setValue(value: indicator.date)
        if let value = indicator.value {
            valueView.setValue(value: "\(value)")
        }
        unitOfMeasurementView.setValue(value: indicator.unitOfMeasurement)
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
