//
//  DealSetupPeopleView.swift
//  studioplus
//
//  Created by Isaac Ho on 8/31/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

class DealSetupPeopleView: UIView, UITableViewDelegate, UITableViewDataSource, DealSetupAddPersonDialogListener {
    
    @IBOutlet weak var peopleTableView: DealSetupPeopleTable!
    
    @IBOutlet weak var collaboratorTableView: DealSetupPeopleTable!
    @IBAction func onAddNewPerson(sender: AnyObject)
    {
        var dialog = DealSetupAddPersonDialog.instanceFromNib(sceneMgr)        
        dialog.setup("", project_: sceneMgr.currentProject, delegate_: self, role_: nil, bIsTalent_: true)
        
        sceneMgr.mainVC.presentViewController(dialog, animated: false, completion: nil)
        
    }
    var sceneMgr: AddProjectSceneManager!

    func onDismiss(person:Person, bDidAdd: Bool, id:String) {
        sceneMgr.mainVC.dismissViewControllerAnimated(false, completion: nil)
 
        if ( bDidAdd ) {
            sceneMgr.currentProject.people.append( person )
            peopleTableView.reloadData()
            self.onAddNewPerson( self )
        }
    }
    // this is a hack b/c I couldn't work this into init() without 
    //   a nil ptr exception
    // so this function must be called manually for the tableView to work right
    func customInit() {
        self.peopleTableView.dataSource = self
        self.peopleTableView.delegate = self
        self.collaboratorTableView.dataSource = self
        self.collaboratorTableView.dataSource = self
        self.setNeedsDisplay()
    }
    class func instanceFromNib(sceneMgr_:AddProjectSceneManager) -> DealSetupPeopleView {
        var newItem = UINib(nibName: "DealSetupPeopleView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! DealSetupPeopleView
        newItem.sceneMgr = sceneMgr_
        newItem.customInit()
        return newItem
    }
    // returns only collaborators, or only non-collaborators
    func getNonCollaborators() -> [Person] { return getCollaborators(true) }
    func getCollaborators() -> [Person] { return getCollaborators(false) }

    func getCollaborators( bExcludeNotInclude: Bool ) -> [Person]{
        var people = sceneMgr.currentProject.getPeopleWithRole("Talent")
        for( var i=0;i<people.count;i++) {
            let bIsCollaborator = people[i].role.getLabel() == "Collaborator"
            
            if ( bIsCollaborator && bExcludeNotInclude || !bIsCollaborator && !bExcludeNotInclude ) {
                people.removeAtIndex(i)
                i--
            }
        }
        return people
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var objects = NSBundle.mainBundle().loadNibNamed("DealSetupPeopleTableCell", owner: self, options: nil)
        var cell = objects[0] as! DealSetupPeopleTableCell
        
        if ( tableView == peopleTableView ) {
            cell.person = getNonCollaborators()[indexPath.row]
        }
        if ( tableView == collaboratorTableView ) {
            cell.collaborators = getCollaborators()
        }
        cell.clipsToBounds = true
        cell.delegate = sceneMgr
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( tableView == peopleTableView ) {
            return getNonCollaborators().count
        }
        if ( tableView == collaboratorTableView ) {
            return getCollaborators().count > 0 ? 1 : 0
        }
        return 0
    }
    
}