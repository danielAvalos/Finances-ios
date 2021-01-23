//
//  DetailIndicatorViewModel .swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

// MARK: - DetailIndicatorViewModelEntityProtocol
final class DetailIndicatorViewModel: DetailIndicatorViewModelEntityProtocol {

    weak var delegate: DetailIndicatorViewModelDelegate?
    var indicator: Indicator?
}

extension DetailIndicatorViewModel: DetailIndicatorViewModelProtocol {
    func prepareDetail() {
        guard let indicator = indicator else {
            delegate?.showError(error: Error(code: .dataNotFound))
            return
        }
        delegate?.showIndicatorInfo(indicator: indicator)
    }
}
