//
//  MockWebView.swift
//  BRTakeHomeTests
//
//  Created by Tanner Perry on 2/14/22.
//

import Foundation
@testable import BRTakeHome


class MockWebView : WebViewProtocol {
    var navigateToUrlCalled = false
    var navigateToUrlPassedUrl : URL?
    func navigateTo(url: URL) {
        navigateToUrlCalled = true
        navigateToUrlPassedUrl = url
    }
    
    var refreshedCalled = false
    func refresh() {
        refreshedCalled = true
    }
    
    var navigateBackCalled = false
    func navigateBack() {
        navigateBackCalled = true
    }
    
    var navigateforwardCalled = false
    func navigateForward() {
        navigateforwardCalled = true
    }
    
    
}
