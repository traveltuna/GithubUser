//
//  BrowserViewController.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import WebKit
import UIKit

final class BrowserViewController: UIViewController {
    @IBOutlet private weak var webView: WKWebView!
    private var urlString: String!
    
    static func instance(with urlString: String) -> BrowserViewController {
        let storyboard = UIStoryboard(name: "Browser", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! BrowserViewController
        vc.urlString = urlString
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
}
