//
//  WikiWebViewController.swift
//  DemoWikiSearch
//
//  Created by Bharat Byan on 23/07/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit
import WebKit

class WikiWebViewController: UIViewController, WKUIDelegate {

    
    var selectedPageId : String?
    var pagetitle: String?
    
    @IBOutlet var wkWebWikiDetail: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        wkWebWikiDetail = WKWebView(frame: .zero, configuration: webConfiguration)
        wkWebWikiDetail.uiDelegate = self
        view = wkWebWikiDetail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = pagetitle

        // Do any additional setup after loading the view.
        let myURL = URL(string: "https://en.m.wikipedia.org/?curid=\(selectedPageId!)")
        let myRequest = URLRequest(url: myURL!)
        wkWebWikiDetail.load(myRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
