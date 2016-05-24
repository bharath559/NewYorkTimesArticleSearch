//
//  DetailViewController.swift
//  NyTimesArticleSearch
//
//  Created by Bharath Kongara on 5/22/16.
//  Copyright © 2016 Bharath Kongara. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var url:String?
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.url)
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string:self.url!)!))
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

