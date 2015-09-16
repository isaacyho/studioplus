//
//  DealQuestionsMasterView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/8/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

class DealQuestionsMasterView: UIView {
    @IBOutlet weak var mainView: UIScrollView!
    @IBAction func onUploadFile(sender: AnyObject) {
    }
    var deal: Deal!
    var sceneMgr: AddProjectSceneManager!
    var roleSpecificQuestionsView: UIView! // also of type TemplateValueHolder
    var mainQuestionsView:UIView!
    
    
    @IBAction func onGenerateDraft(sender: AnyObject) {
        // add in 
        // print out all the template values
        sceneMgr.currentProject.setTemplateValues(deal)
        
        var v = mainQuestionsView as! TemplateValueHolder
        v.setTemplateValues(deal)
        v = roleSpecificQuestionsView as! TemplateValueHolder
        v.setTemplateValues(deal)
        println("snapshotValues: \(deal.snapshotValues)")
        
        // this will save associated project and associated person as well ( right? )
        sceneMgr.currentDeal.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if success {
                NSLog("success")
            } else {
                NSLog("error: \(error)")
            }
        }
        
        sceneMgr.jumpToScene(AddProjectSceneManager.Scenes.ReviewAndSign)

    }
    // make a deal for this particular person in this given project
    func setModel( deal_: Deal ){
        deal = deal_
        
        // determine role
        assert(deal_.signors.count >= 2 )
        var role = deal_.signors[1].role
        
        mainView.contentSize = CGSize(width: 670, height: 2000)
        var yCoord=0
        switch( role.getLabel()) {
            case "Writer":
                // xxx should be able to get preferredHeight from nib somehow?
                roleSpecificQuestionsView = DealQuestionsWriterView.instanceFromNib()
                roleSpecificQuestionsView.frame = CGRect(x:0,y:yCoord,width:670,height:240)
                mainView.addSubview(roleSpecificQuestionsView)
                yCoord += 240
            default: break;
        }
        mainView.addSubview(roleSpecificQuestionsView)

        mainQuestionsView = DealQuestionsTalentView.instanceFromNib()
        mainQuestionsView.frame = CGRect(x:0,y:yCoord,width:670,height:1500)
        mainView.addSubview(mainQuestionsView)
        mainView.frame = mainView.bounds

    }
    override func layoutSubviews() {
        // at this point,
        
        
    }
    class func instanceFromNib(sceneMgr_:AddProjectSceneManager) -> DealQuestionsMasterView {
        var newItem = UINib(nibName: "DealQuestionsMasterView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DealQuestionsMasterView
        newItem.sceneMgr = sceneMgr_
        
        return newItem
    }
}