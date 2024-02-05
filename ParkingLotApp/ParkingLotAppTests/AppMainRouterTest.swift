//
//  AppMainRouterTest.swift
//  ParkingLotAppTests
//
//  Created by Ronak Malick on 06/02/24.
//

import XCTest
@testable import ParkingLotApp

final class AppMainRouterTest: XCTestCase {
    var window: UIWindow!
    var navigationController: UINavigationController!
    var sut: AppMainRouter!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        navigationController = UINavigationController()
        sut = AppMainRouter(window: window, navigationController: navigationController)
    }
    
    override func tearDown() {
        sut = nil
        navigationController = nil
        window = nil
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.window, window)
        XCTAssertEqual(sut.navigationController, navigationController)
    }
    
    func testLaunch() {
        sut.launch()
        
        XCTAssertNotNil(window.rootViewController)
        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.viewControllers.first is AuthenticationViewController)
    }
    
    
}
