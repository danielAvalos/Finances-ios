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

    func testWhenList_isEmpty() throws {
        let response = IndicatorsResponse(version: nil, author: nil, date: nil, indicators: [])
        let mockService = MockIndicatorService(response: response, error: nil)
        let viewModel = ListViewModel(service: mockService)
        viewModel.prepareList()
        XCTAssertEqual(viewModel.indicators, [])
    }

    func testWhenTheService_returnError() throws {
        let error = Error(code: .errorServer)
        let mockService = MockIndicatorService(response: nil, error: error)
        let monitorListViewModelDelegate = MonitorListViewModelDelegate()
        let viewModel = ListViewModel(service: mockService)
        viewModel.delegate = monitorListViewModelDelegate
        monitorListViewModelDelegate.stateDidChange = { state in
            XCTAssertEqual(state, .loading)
            //XCTAssertEqual(state, .failed(error: error))
        }
        viewModel.prepareList()
    }

    func testWhenCallService_inOfflineMode_withData() throws {
    }
    
    func testWhenCallService_inOfflineMode_WithOutData() throws {
    }
}
