//
//  HistoricalValuesViewController.swift
//  Finances
//
//  Created by DESARROLLO on 27/01/21.
//

import UIKit
import Charts

final class HistoricalValuesViewController: UIViewController {

    @IBOutlet private weak var chartView: LineChartView! {
        didSet {
            chartView.isHidden = true
            chartView.backgroundColor = UIColor.color(named: .green)
            chartView.delegate = self
        }
    }

    var viewModel: (HistoricalValuesViewModelProtocol & HistoricalValuesViewModelEntityProtocol)?

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
        viewModel?.prepareHistorical()
    }
}

// MARK: - HistoricalValuesViewModelDelegate
extension HistoricalValuesViewController: HistoricalValuesViewModelDelegate {

    func showError(error: Error) {
        showAlert(title: error.title, message: error.description )
    }

    func showHistoricalIndicator(data: ChartData) {
        chartView.data = data
        chartView.isHidden = false
    }
}

// MARK: - ChartViewDelegate
extension HistoricalValuesViewController: ChartViewDelegate {
}

// MARK: - Private functions
private extension HistoricalValuesViewController {

    func setup() {
        HistoricalValuesConfigurator.configure(self)
    }
}
