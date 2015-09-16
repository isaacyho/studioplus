//
//  DealSignView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/11/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

class DealSignView: UIView {
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var sigPanelView: UIView! // contains selector + signature
    @IBOutlet weak var signatureView: YPDrawSignatureView! // signature itself
    
    @IBOutlet weak var buttonPanelView: UIView!
    var sceneMgr: AddProjectSceneManager!
    
    class func instanceFromNib(sceneMgr_:AddProjectSceneManager) -> DealSignView {
        var newItem = UINib(nibName: "DealSignView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DealSignView
        newItem.sceneMgr = sceneMgr_
        
        newItem.sigPanelView.hidden = true
        
        return newItem
    }

    @IBAction func onDoneSigning(sender: AnyObject) {
        // xxx capture the signature in an object here
        
        buttonPanelView.hidden = false
        sigPanelView.hidden = true
    }
    @IBAction func onSendToSignor(sender: AnyObject) {
        // dialog message sent
    }
    @IBAction func onSignLater(sender: AnyObject) {
        sceneMgr.jumpToScene(AddProjectSceneManager.Scenes.DealSetup)
    }
    @IBAction func onSignNow(sender: AnyObject) {
        buttonPanelView.hidden = true
        sigPanelView.hidden = false
    }
    @IBAction func onEditDeal(sender: AnyObject) {
        sceneMgr.jumpToScene(AddProjectSceneManager.Scenes.DealSetup)
    }
    @IBAction func onSelectSignor(sender: AnyObject) {
        
    }
    
    override func layoutSubviews() {
        loadDummyDealObjects()
    }
    
    
    func loadDummyDealObjects() {
        var query = PFQuery(className: "DummyDeal" )
        
        var obj = query.getFirstObject()
        var deal:DummyDeal = obj as! DummyDeal
        var urlString = deal.document.url!
        var url = NSURL(string: urlString)
        var request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
    }

}