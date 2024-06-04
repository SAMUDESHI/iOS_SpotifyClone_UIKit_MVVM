//
//  AuthViewController.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    private let webView : WKWebView = {
        let pref = WKWebpagePreferences()
        pref.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = pref
        let webView = WKWebView(frame: .zero,configuration: config)
        return webView
    }()
    
    public var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        guard let url = AuthManager.shared.signInURL else{
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
}


extension AuthViewController : WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else{
            return
        }
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: {$0.name == "code"})?.value
        else {
            return
        }
        AuthManager.shared.excahngeCodeForToken(code: code, completion: {
            [weak self] sucess in
            DispatchQueue.main.async{
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(sucess)
            }
        })
        print("Code :\(code)")
    }
}
