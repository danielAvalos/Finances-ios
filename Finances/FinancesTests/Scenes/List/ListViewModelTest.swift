//
//  ListViewModelTest.swift
//  FinancesTests
//
//  Created by DESARROLLO on 22/01/21.
//

import XCTest
@testable import Finances

class ListViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenListIsEmpty() throws {
        let response = IndicatorsResponse(version: nil, author: nil, date: nil, indicators: [])
        let mocService = MocIndicatorService(response: response, error: nil)
        let viewModel = ListViewModel(service: mocService)
        viewModel.prepareList()
        XCTAssertEqual(viewModel.indicators, [])
    }

    func testWhenTheServiceReturnError() throws {
        let error = Error(code: .errorServer)
        let mocService = MocIndicatorService(response: nil, error: error)
        let monitorListViewModelDelegate = MonitorListViewModelDelegate()
        let viewModel = ListViewModel(service: mocService)
        viewModel.delegate = monitorListViewModelDelegate
        monitorListViewModelDelegate.stateDidChange = { state in
            XCTAssertEqual(state, .loading)
            //XCTAssertEqual(state, .failed(error: error))
        }
        viewModel.prepareList()
    }

    func testWhenCallServiceInOfflineModeWithData() throws {
    }
    
    func testWhenCallServiceInOfflineModeWithOutData() throws {
    }
}
