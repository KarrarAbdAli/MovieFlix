//
//  WebViewController.swift
//  MovieFlix
//
//  Created by Karrar Abd Ali on 04/08/2021.
//  Copyright © 2021 Karrar Abd Ali. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    private var url: String = ""
    
    var webView: WKWebView?
    
    init(movieId:Int) {
        self.url = (Constants.API.movieWebBaseUrl + String(movieId)).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.frame)
        setupWebView()
        loadWebPage()
    }
    
    private func setupWebView() {
        guard let webView = webView else {return}
        view.addSubview(webView)
        NSLayoutConstraint.activate([webView.topAnchor.constraint(equalTo: view.topAnchor),
                                     webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     webView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     webView.leftAnchor.constraint(equalTo: view.leftAnchor)])
    }
    
    private func loadWebPage() {
        guard  !url.isEmpty, let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        webView?.load(request)
    }
}
