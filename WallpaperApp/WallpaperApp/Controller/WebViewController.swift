//
//  WebViewController.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/07/05.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    private let webView: WKWebView
    private let url: URL

    init(url: URL) {
        self.url = url
        let webConfiguration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame = view.bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self

        let request = URLRequest(url: url)
        webView.load(request)

        setupCloseButton()
    }

    private func setupCloseButton() {
        let closeButton = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(dismissSelf))
        closeButton.tintColor = .black
        navigationItem.rightBarButtonItem = closeButton
    }

    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
