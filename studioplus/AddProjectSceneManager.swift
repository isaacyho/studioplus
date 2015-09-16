//
//  AddProjectSceneManager.swift
//  studioplus
//

/*
Handles business logic for the AddProject scene.  Sits above and coordinates  main view controller with various needed views ( xibs+swift ).

Typical flow:
- show: project details view
-
*/
//  Created by Isaac Ho on 8/31/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

class AddProjectSceneManager: MakeDealListener
{
    enum Scenes:Int {
       case ProjectDetails=0,DealSetup,DealQuestions,ReviewAndSign
    }
    var sidebar: AddNewProjectSidebar!
    var mainVC: ViewController!
    var currentProject: Project!
    var currentScene: Scenes = .ProjectDetails
    var currentMainView: UIView?
    var currentDeal: Deal!
    
    init( mainVC_: ViewController ) {
        mainVC = mainVC_
        currentProject = Project()
        currentProject.manualInit()
    }
    func goBack() {
        if ( currentScene.rawValue > 0 ) {
           jumpToScene(Scenes(rawValue: currentScene.rawValue - 1 )!)
        }
    }
    func onMakeDeal(person: Person) {
        // you know the current scene and current project, jump to the correct screen
        // set up the deal
        currentDeal = Deal()
        currentDeal.manualInit()
        var owner=Person()
        owner.manualInit()
        owner.role = Role.getInstanceOf("Owner")!
        currentDeal.signors.append( owner )
        currentDeal.signors.append( person )
        currentDeal.project = currentProject
        
        person.setTemplateValues(currentDeal)
        currentProject.setTemplateValues(currentDeal)
        
        jumpToScene( Scenes.DealQuestions )
    }
    func jumpToScene( scene: Scenes ) {
        if ( currentMainView != nil ) {
            switch ( currentScene ) {
                case .ProjectDetails:
                    // handle the validation of project details HERE
                    if ( scene.rawValue > currentScene.rawValue ) {
                        var projectDetailsView = currentMainView as! ProjectDetailsView
                        currentProject.bIsSingleProject = projectDetailsView.singleProjectSegControl.selectedSegmentIndex == 0
                        currentProject.bIsScripted = projectDetailsView.scriptedSegControl.selectedSegmentIndex == 0
                        currentProject.title = projectDetailsView.titleTextField.text
                        
                        let a = projectDetailsView.totalNumberProductionYears.text.toInt()
                        currentProject.totalNumberProductionYears = a != nil ? a! : 0

                        currentProject.numCollaborators = Int(projectDetailsView.numProjectCreatorsStepper.value)
                        currentProject.startDate = projectDetailsView.startDatePicker.date
                        currentProject.endDate = projectDetailsView.endDatePicker.date
                        let b = projectDetailsView.numEpisodesTextField.text.toInt()
                        currentProject.numEpisodes = b != nil ? b! : 0
                        currentProject.videoLink = projectDetailsView.videoLinkTextField.text
                        currentProject.publicProfileName = projectDetailsView.publicProfileNameTextField.text
                        currentProject.tagLine = projectDetailsView.tagLineTextField.text
                        currentProject.mediaTypes = projectDetailsView.mediaTypesTextField.text
                    }
                default: break
            }
        }
        switch( scene ) {
            case .ProjectDetails: currentMainView = ProjectDetailsView.instanceFromNib(self)
                var detailsView = currentMainView as! ProjectDetailsView
                detailsView.setModel( self )
                mainVC.backButton.hidden = true
            case .DealSetup: currentMainView = DealSetupView.instanceFromNib(self)
                mainVC.backButton.hidden = false
                mainVC.backButton.titleLabel!.text = "< Project Details"

            case .DealQuestions:
                // hack
                var view = DealQuestionsMasterView.instanceFromNib(self)
                view.setModel(currentDeal)
                currentMainView = view
                mainVC.backButton.hidden = false
                mainVC.backButton.titleLabel!.text = "< Deal Questions"

            case .ReviewAndSign:
                var view = DealSignView.instanceFromNib(self)
                currentMainView = view
                mainVC.backButton.hidden = false
                mainVC.backButton.titleLabel!.text = "< Review and Sign"
        }
        if let currentMainView = currentMainView  {
            mainVC.setMainPanelView( currentMainView )
        }
        currentScene = scene
        sidebar.setCurrentScene(scene)
    }
    
    // user clicked 'Make Deal'
    // - validate that all required fields are specified ( besides the deal ? of course )
    // - save project to db
    // - move to deal questions
    func onMakeDeal() {
        
    }
    /*
    outlets from sidebar class
        addnewprojectsidebar: "dealsetupClicked" 
            setMainPanel( DealSetup.xib )
        */
    func begin() {
        sidebar = AddNewProjectSidebar.instanceFromNib(self)
        mainVC.sceneMgr = self
       mainVC.setSidebarView( sidebar )
       jumpToScene( Scenes.ProjectDetails )
    }
}

