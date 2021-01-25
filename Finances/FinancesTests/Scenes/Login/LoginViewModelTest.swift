//
//  LoginViewModelTest.swift
//  FinancesTests
//
//  Created by DESARROLLO on 22/01/21.
//

import XCTest
@testable import Finances

class LoginViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserIsInvalid() throws {
        // Given
        let monitorViewModelDelegate = MonitorLoginViewModelDelegate()
        let viewModel = LoginViewModel()
        viewModel.userName = "prueba"
        viewModel.password = "12345"
        viewModel.delegate = monitorViewModelDelegate
        monitorViewModelDelegate.loginDidFailWithError = { error in
            // Then
            XCTAssertEqual(error, Error(code: .userInvalid))
        }

        // When
        viewModel.login()
    }

    func testUser_isValid() throws {
        // Given
        let monitorViewModelDelegate = MonitorLoginViewModelDelegate()
        let viewModel = LoginViewModel()
        viewModel.userName = "prueba"
        viewModel.password = "123456"
        viewModel.delegate = monitorViewModelDelegate
        monitorViewModelDelegate.loginDidCompleteHandler = {
            // Then
            XCTAssertTrue(true, "User is valid")
        }
        
        // When
        viewModel.login()
    }

    func testWhenDoNotEnter_username() throws {
        // Given
        let monitorViewModelDelegate = MonitorLoginViewModelDelegate()
        let viewModel = LoginViewModel()
        viewModel.userName = ""
        viewModel.password = "123456"
        viewModel.delegate = monitorViewModelDelegate
        monitorViewModelDelegate.loginDidFailWithError = { error in
            // Then
            XCTAssertEqual(error, Error(code: .notUserName))
        }
        // When
        viewModel.login()
    }

    func testWhenDoNotEnter_password() throws {
        // Given
        let monitorViewModelDelegate = MonitorLoginViewModelDelegate()
        let viewModel = LoginViewModel()
        viewModel.userName = "prueba"
        viewModel.password = ""
        viewModel.delegate = monitorViewModelDelegate
        monitorViewModelDelegate.loginDidFailWithError = { error in
            // Then
            XCTAssertEqual(error, Error(code: .notPassword))
        }
        // When
        viewModel.login()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
