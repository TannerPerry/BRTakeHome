//
//  WebViewPresenterTests.swift
//  BRTakeHomeTests
//
//  Created by Tanner Perry on 2/14/22.
//

import XCTest
@testable import BRTakeHome

class WebViewPresenterTests: XCTestCase {
    
    var presenter : WebViewPresenter?
    
    var webview = MockWebView()

    override func setUpWithError() throws {
        presenter = WebViewPresenter(webView: webview)
        guard let bottleRocketURL = URL(string: "https://www.bottlerocketstudios.com") else {
            XCTFail()
            return
        }
        XCTAssertTrue(webview.navigateToUrlCalled)
        XCTAssertEqual(webview.navigateToUrlPassedUrl, bottleRocketURL)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRefreshPressed() {
        presenter?.refreshPressed()
        XCTAssertTrue(webview.refreshedCalled)
        
    }
    
    func testBackPressed() {
        presenter?.backPressed()
        XCTAssertTrue(webview.navigateBackCalled)
    }
    
    func testForwardPressed() {
        presenter?.forwardPressed()
        XCTAssertTrue(webview.navigateforwardCalled)
    }
}
