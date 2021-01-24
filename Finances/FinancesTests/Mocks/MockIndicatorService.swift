//
//  MocIndicatorService.swift
//  FinancesTests
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

struct MockIndicatorService: IndicatorServiceProtocol {

    var response: IndicatorsResponse?
    var error: Error?

    func getIndicatorsList(completionHandler: @escaping (IndicatorsResponse?, Error?) -> Void) {
        DispatchQueue.main.async {
            guard let response = self.response else {
                completionHandler(nil, error)
                return
            }
            completionHandler(response, nil)
        }
    }
}
