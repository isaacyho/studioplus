//
//  TestViewController.swift
//  studioplus
//
//  Created by Isaac Ho on 9/10/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var sigView: YPDrawSignatureView!
    @IBOutlet weak var webView: UIWebView!
    // be sure you can load them as well
    func loadDummyDealObjects() {
        var query = PFQuery(className: "DummyDeal" )
            
        var obj = query.getFirstObject()
        var deal:DummyDeal = obj as! DummyDeal
        var urlString = deal.document.url!
        var url = NSURL(string: urlString)
        var request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadDummyDealObjects()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
