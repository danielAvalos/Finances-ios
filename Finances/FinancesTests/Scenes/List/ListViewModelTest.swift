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
        // Given
        let response = IndicatorsResponse(version: nil, author: nil, date: nil, indicators: [])
        let mockService = MockIndicatorService(response: response, error: nil)
        let viewModel = ListViewModel(service: mockService)
        // When
        viewModel.prepareList()
        // Then
        XCTAssertEqual(viewModel.indicators, [])
    }

    func testWhenTheService_returnError() throws {
        // Given
        let errorMock = Error(code: .errorServer)
        let mockService = MockIndicatorService(response: nil, error: errorMock)
        var firstCall = true

        let monitorListViewModelDelegate = MonitorListViewModelDelegate()
        let viewModel = ListViewModel(service: mockService)
        viewModel.delegate = monitorListViewModelDelegate
        monitorListViewModelDelegate.stateDidChange = { state in
            // Then
            switch state {
            case .loading:
                XCTAssert(firstCall, "")
                firstCall = false
            case let .failed(error):
                XCTAssertEqual(error, errorMock)
            default:
                XCTAssertFalse(firstCall)
            }
        }
        // When
        viewModel.prepareList()
    }
    
    func testfilterText_thatDoesNot_exist() throws {
        // Given
        let fileUrl = Bundle(for: type(of: self)).path(forResource: "IndicatorResponse", ofType: "json")!
        let data = try Data(contentsOf: URL(fileURLWithPath: fileUrl), options: .mappedIfSafe)
      let indicatorResponseMock = try JSONDecoder().decode(IndicatorsResponse.self, from: data)
        let mockService = MockIndicatorService(response: indicatorResponseMock, error: nil)
        let monitorListViewModelDelegate = MonitorListViewModelDelegate()
        let viewModel = ListViewModel(service: mockService)
        viewModel.delegate = monitorListViewModelDelegate
        monitorListViewModelDelegate.stateDidChange = { state in
            // Then
            XCTAssertEqual(viewModel.indicators.count, 0)
        }
        // When
        viewModel.filterContent(forQuery: "dataNotFound")
    }
    
    func testfilterText_thatYes_exist() throws {
        // Given
        let fileUrl = Bundle(for: type(of: self)).path(forResource: "IndicatorResponse", ofType: "json")!
        let data = try Data(contentsOf: URL(fileURLWithPath: fileUrl), options: .mappedIfSafe)
        let indicatorResponseMock = try JSONDecoder().decode(IndicatorsResponse.self, from: data)
        let mockService = MockIndicatorService(response: indicatorResponseMock, error: nil)
        let monitorListViewModelDelegate = MonitorListViewModelDelegate()
        let viewModel = ListViewModel(service: mockService)
        viewModel.indicators = indicatorResponseMock.indicators
        viewModel.unfilteredIndicators = viewModel.indicators
        monitorListViewModelDelegate.stateDidChange = { state in
            // Then
            switch state {
            case .ready:
                XCTAssertGreaterThanOrEqual(viewModel.indicators.count, 1)
            default:
                XCTAssertEqual(viewModel.indicators.count, indicatorResponseMock.indicators.count)
            }
        }
        viewModel.delegate = monitorListViewModelDelegate

        // When
        viewModel.filterContent(forQuery: "dolar")
    }

    func testWhenCallService_inOfflineMode_withData() throws {
    }
    
    func testWhenCallService_inOfflineMode_WithOutData() throws {
    }
}
