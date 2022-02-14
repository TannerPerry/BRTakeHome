//
//  WebViewController.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/12/22.
//

import UIKit
import WebKit

protocol WebViewProtocol {
    func navigateTo(url:URL)
    func refresh()
    func navigateBack()
    func navigateForward()
}

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    
    var webView: WKWebView!
    var backButton: UIButton!
    var refreshButton: UIButton!
    var forwardButton: UIButton!
    
    var presenter : WebViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createWebView()
        addButtons()
        
        presenter = WebViewPresenter(webView: self)
    }
    
    func createWebView() {
        self.webView = WKWebView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        self.view.addSubview(webView)
    }
    
    func addButtons() {
        
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        backButton.setImage(UIImage(named: "ic_webBack"), for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        let back = UIBarButtonItem(customView: backButton)
        
        refreshButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        refreshButton.setImage(UIImage(named: "ic_webRefresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        let refresh = UIBarButtonItem(customView: refreshButton)
        
        forwardButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        forwardButton.setImage(UIImage(named: "ic_webForward"), for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardTapped), for: .touchUpInside)
        let forward = UIBarButtonItem(customView: forwardButton)
        
        navigationItem.setLeftBarButtonItems([back, refresh, forward], animated: false)
        
    }
    
    @objc func backTapped() {
        presenter?.backPressed()
    }
    
    @objc func refreshTapped() {
        presenter?.refreshPressed()
    }
    
    @objc func forwardTapped() {
        presenter?.forwardPressed()
    }
}

extension WebViewController: WebViewProtocol {
    func refresh() {
        webView.reload()
    }
    
    func navigateBack() {
        webView.goBack()
    }
    
    func navigateForward() {
        webView.goForward()
    }
    
    func navigateTo(url: URL) {
        let myURLRequest: URLRequest = URLRequest(url: url)
        webView.load(myURLRequest)
    }
    
    
}

