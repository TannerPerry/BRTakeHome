//
//  WebViewPresenter.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/14/22.
//

import Foundation

class WebViewPresenter {
    var webView : WebViewProtocol
    
    public init(webView: WebViewProtocol) {
        self.webView = webView
        navigateWeb()
    }
    
    func navigateWeb() {
        if let bottleRocketURL = URL(string: "https://www.bottlerocketstudios.com") {
            webView.navigateTo(url:bottleRocketURL)
        }
    }
    
    func refreshPressed() {
        webView.refresh()
    }
    
    
    func backPressed() {
        webView.navigateBack()
    }
    
    func forwardPressed() {
        webView.navigateForward()
    }
    
}
