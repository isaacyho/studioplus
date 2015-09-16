//
//  DealSetupLocationView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/4/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

class DealSetupLocationView: UIView, UITableViewDelegate, UITableViewDataSource, DealSetupAddLocationDialogListener, DealSetupAddPersonDialogListener {
    
    @IBOutlet weak var locationTableView: UITableView!
    var sceneMgr: AddProjectSceneManager!
    
    // Logic: fire off an addperson window now.  Handler listens for close event.  At that point, that handler fires off an AddLocation dialog, and loops back here if needed
    @IBAction func onAddNewLocation(sender: AnyObject) {
        var dialogPerson = DealSetupAddPersonDialog.instanceFromNib(sceneMgr)
        dialogPerson.setup( "location", project_:sceneMgr.currentProject, delegate_:self, role_: Role.getInstanceOf("Location"), bIsTalent_:false )
        
        sceneMgr.mainVC.presentViewController(dialogPerson, animated: false, completion: nil)
        
    }
    func onDismiss(person: Person, bDidAdd: Bool, id: String) {
        sceneMgr.mainVC.dismissViewControllerAnimated(false, completion: nil)
     
        if ( bDidAdd ) {
            sceneMgr.currentProject.people.append( person )
        }
        var dialogLocation = DealSetupAddLocationDialog.instanceFromNib(sceneMgr)
        dialogLocation.setup(self)
        sceneMgr.mainVC.presentViewController(dialogLocation, animated: false, completion: nil)
    }
    func onDismissLocationDialog(location: Location, bDidAdd: Bool, id: String) {
        sceneMgr.mainVC.dismissViewControllerAnimated(false, completion: nil)
        
        if ( bDidAdd ) {
            sceneMgr.currentProject.locations.append( location )
            locationTableView.reloadData()

            self.onAddNewLocation( self )
        }
    }
  
    // this is a hack b/c I couldn't work this into init() without
    //   a nil ptr exception
    // so this function must be called manually for the tableView to work right
    func customInit() {
        self.locationTableView.dataSource = self
        self.locationTableView.delegate = self
        self.setNeedsDisplay()
    }
    class func instanceFromNib(sceneMgr_:AddProjectSceneManager) -> DealSetupLocationView {
        var newItem = UINib(nibName: "DealSetupLocationView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! DealSetupLocationView
        newItem.sceneMgr = sceneMgr_
        newItem.customInit()
        return newItem
    }
    
    var selectedIndexPath:NSIndexPath?
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var objects = NSBundle.mainBundle().loadNibNamed("DealSetupAddLocationTableCell", owner: self, options: nil)
        var cell = objects[0] as! DealSetupAddLocationTableCell
  
        /* send in all locations for a given person */
        var p = self.sceneMgr.currentProject.getPeopleWithRole("Location")[indexPath.row]
        var locs = self.sceneMgr.currentProject.getLocationsForPerson(p)
        cell.setModel(p, locations_: locs)
        cell.clipsToBounds = true
        cell.delegate = sceneMgr
    
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sceneMgr.currentProject.getPeopleWithRole("Location").count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if ( indexPath == selectedIndexPath ) {
            return 120.0
        }
        return 40.0
    }
    /* if expanded, show larger one */
    
}