//
//  AddNewProjectSidebar.swift
//  studioplus
//
//  Created by Isaac Ho on 8/31/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

class AddNewProjectSidebar: UIView {
    var sceneMgr: AddProjectSceneManager! // should use an interface
    
    @IBOutlet weak var projectDetailsButton: UIButton!
    @IBOutlet weak var dealSetupButton: UIButton!
    @IBOutlet weak var dealQuestionsButton: UIButton!
    @IBOutlet weak var reviewSignButton: UIButton!
    class func instanceFromNib( sceneMgr_: AddProjectSceneManager ) -> AddNewProjectSidebar {
        var newItem = UINib(nibName: "AddNewProjectSidebar", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! AddNewProjectSidebar
        newItem.sceneMgr = sceneMgr_
        
        return newItem
    }
    func setCurrentScene( scene: AddProjectSceneManager.Scenes) {
        projectDetailsButton.selected = scene == .ProjectDetails        
        dealSetupButton.selected = scene == .DealSetup
        dealQuestionsButton.selected = scene == .DealQuestions
        reviewSignButton.selected = scene == .ReviewAndSign
        
    }
    @IBAction func onProjectDetails(sender: AnyObject) {
        //sceneMgr.jumpToScene(AddProjectSceneManager.Scenes.ProjectDetails)
    }
    
    @IBAction func onDealSetup(sender: AnyObject) {
        //sceneMgr.jumpToScene( AddProjectSceneManager.Scenes.DealSetup )
    }
    @IBAction func onDealQuestions(sender: AnyObject) {
        //sceneMgr.jumpToScene( AddProjectSceneManager.Scenes.DealQuestions )
    }
    
    @IBAction func onReviewSign(sender: AnyObject) {
        //sceneMgr.jumpToScene(AddProjectSceneManager.Scenes.ReviewAndSign )
    }
    
}