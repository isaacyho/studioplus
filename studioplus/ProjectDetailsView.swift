//
//  ProjectDetailsView.swift
//  studioplus
//
//  Created by Isaac Ho on 8/31/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

class ProjectDetailsView: UIView, kHackedDropDownListViewDelegate {
    var sceneMgr: AddProjectSceneManager!
    
    @IBOutlet weak var singleProjectSegControl: UISegmentedControl!
    
    @IBOutlet weak var scriptedSegControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var totalNumberProductionYears: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numProjectCreatorsStepper: UIStepper! // # collaborators
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var numProjectCreatorsLabel: UILabel!
    
    @IBOutlet weak var numEpisodesTextField: UITextField!
    @IBOutlet weak var videoLinkTextField: UITextField!
    @IBOutlet weak var publicProfileNameTextField: UITextField!
    
    @IBOutlet weak var episodicView: UIView!
    
    @IBOutlet weak var tagLineTextField: UITextField!
    
    @IBOutlet weak var mediaTypesTextField: UITextField!
   
    override func layoutSubviews() {
        numProjectCreatorsStepper.value = 0
        onSingleProjectChange(self)
        
        titleTextField.delegate = sceneMgr.mainVC
        totalNumberProductionYears.delegate = sceneMgr.mainVC
        descriptionTextField.delegate = sceneMgr.mainVC
        tagsTextField.delegate = sceneMgr.mainVC
        nameTextField.delegate = sceneMgr.mainVC
        numEpisodesTextField.delegate = sceneMgr.mainVC
        videoLinkTextField.delegate = sceneMgr.mainVC
        publicProfileNameTextField.delegate = sceneMgr.mainVC
        mediaTypesTextField.delegate = sceneMgr.mainVC
        tagLineTextField.delegate = sceneMgr.mainVC
        
    }
    @IBAction func onSaveAndContinue(sender: AnyObject) {
        
        sceneMgr.currentProject.name = nameTextField.text
        sceneMgr.currentProject.bIsSingleProject = singleProjectSegControl.selectedSegmentIndex == 0
        sceneMgr.currentProject.bIsScripted = scriptedSegControl.selectedSegmentIndex == 0
        sceneMgr.currentProject.title = titleTextField.text
        sceneMgr.currentProject.tags = tagsTextField.text
        sceneMgr.currentProject.numCollaborators = 0
        if let x = numProjectCreatorsLabel.text!.toInt() {
            sceneMgr.currentProject.numCollaborators = x
        }
        sceneMgr.currentProject.startDate = startDatePicker.date
        sceneMgr.currentProject.endDate = endDatePicker.date
        sceneMgr.currentProject.numEpisodes = 0
        if let x = numEpisodesTextField.text!.toInt() {
            sceneMgr.currentProject.numEpisodes = x
        }
        sceneMgr.currentProject.videoLink = videoLinkTextField.text
        sceneMgr.currentProject.publicProfileName = publicProfileNameTextField.text
        sceneMgr.currentProject.tagLine = tagLineTextField.text
        sceneMgr.currentProject.mediaTypes = mediaTypesTextField.text
        sceneMgr.currentProject.totalNumberProductionYears = 0
        if let x = totalNumberProductionYears.text!.toInt() {
            sceneMgr.currentProject.totalNumberProductionYears = x
        }
        sceneMgr.currentProject.descriptionText = descriptionTextField.text
        
        
        sceneMgr.currentProject.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if success {
                NSLog("success")
            } else {
                NSLog("error: \(error)")
            }
        }
        sceneMgr.jumpToScene(AddProjectSceneManager.Scenes.DealSetup)
    }
    
    var mediaTypes = ["Film", "TV", "Web Series/Internet Video","YouTube", "Vimeo Instagram", "Snapchat", "Vine", "Podcast", "Music Video", "Other"]
    var selectedMediaTypeIndices:[Int] = []
    
    /* dropdownlist code BEGIN */
    func didSelectIndex(anIndex: Int, withId id: String!, inOptions vOptions:[AnyObject]!) {
             println("selected index: \(anIndex)")
    }
    func didSelectIndices(indices: [AnyObject]!, withId id: String!, inOptions vOptions:[AnyObject]!) {
        selectedMediaTypeIndices = []
        var str = ""
        for i in indices {
            var swiftI = i as! Int
            str += mediaTypes[swiftI] + " "
        }
        
        mediaTypesTextField.text = str
    }
    func setModel( sceneMgr_: AddProjectSceneManager ) {
        sceneMgr = sceneMgr_
        var p = sceneMgr.currentProject
        
        singleProjectSegControl.selectedSegmentIndex = p.bIsSingleProject ? 0 : 1
        scriptedSegControl.selectedSegmentIndex = p.bIsScripted ? 0 : 1
        titleTextField.text = p.title
        totalNumberProductionYears.text = "\(p.totalNumberProductionYears)"
        numProjectCreatorsStepper.value = Double(p.numCollaborators)
        startDatePicker.date = p.startDate
        endDatePicker.date = p.endDate
        numEpisodesTextField.text = "\(p.numEpisodes)"
        videoLinkTextField.text = p.videoLink
        publicProfileNameTextField.text = p.publicProfileName
        tagLineTextField.text = p.tagLine
        mediaTypesTextField.text = p.mediaTypes
        
        numProjectCreatorsChanged( numProjectCreatorsStepper )
    }
    @IBAction func onShowDropDown(sender: AnyObject) {
        var pos = CGPoint(x:0,y:10)
        var size = CGSize(width:300,height:300)
        
        if ( mediaTypes.count == 0 ) { return }
        var dropObj = DropDownListView(title: "Role", options: mediaTypes, xy: pos, size: size , isMultiple: true, id: "")
        
        dropObj.delegate = self
        dropObj.showInView(self, animated: false)
        dropObj.SetBackGroundDropDwon_R(0.0, g: 108.0, b: 194.0, alpha: 0.70)
        
    }
    /* dropdownlist code END */
    @IBAction func numProjectCreatorsChanged(sender: AnyObject) {
        numProjectCreatorsLabel.text =  Int(numProjectCreatorsStepper.value).description
    }
    @IBAction func onSingleProjectChange(sender: AnyObject) {
        var bIsEpisodic = ( singleProjectSegControl.selectedSegmentIndex == 1 )
        episodicView.hidden = !bIsEpisodic
    }
    class func instanceFromNib(sceneMgr_:AddProjectSceneManager) -> ProjectDetailsView {
        var newItem = UINib(nibName: "ProjectDetailsView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ProjectDetailsView
        newItem.sceneMgr = sceneMgr_
        return newItem
    }
    // onSave - take a reference 
}