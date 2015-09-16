//
//  DealSetupMusicView.swift
//  studioplus
//
//  Created by Isaac Ho on 8/31/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

class DealSetupMusicView: UIView, DealSetupAddPersonDialogListener, DealSetupMusicAddTrackDialogListener {
    
    
    class PeopleTableDelegate: NSObject,UITableViewDataSource, UITableViewDelegate {
        var sceneMgr:AddProjectSceneManager!
        var selectedIndexPath: NSIndexPath?
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            var objects = NSBundle.mainBundle().loadNibNamed("DealSetupTrackPersonTableCell", owner: self, options: nil)
            var cell = objects[0] as! DealSetupTrackPersonTableCell
            
            var p = sceneMgr.currentProject.getPeopleWithRole( "Music" )[ indexPath.row ]
            var tr = sceneMgr.currentProject.getTracksForPerson( p )
            cell.setModel(p, t: tr)
            cell.clipsToBounds = true
            cell.delegate = sceneMgr
            return cell
        }
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            selectedIndexPath = indexPath
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            var musicPeople = sceneMgr.currentProject.getPeopleNamesWithRole( "Music" )

            return musicPeople.count
        }
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            if ( selectedIndexPath == indexPath ) {
                return 120.0
            }
            return 40.0
        }
    }
    class TrackTableDelegate: NSObject,UITableViewDataSource, UITableViewDelegate {
        var sceneMgr:AddProjectSceneManager!
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var objects = NSBundle.mainBundle().loadNibNamed("DealSetupTrackTableCell", owner: self, options: nil)
            var cell = objects[0] as! DealSetupTrackTableCell
            cell.trackNameLabel.text = sceneMgr.currentProject.tracks[ indexPath.row ].name + " (track portion:track len )" // add track portion / track length
            cell.clipsToBounds = true

            return cell
        }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sceneMgr.currentProject.tracks.count
        }
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 80
        }
    }
    
    func onDismiss(person: Person, bDidAdd: Bool, id:String) {
        sceneMgr.mainVC.dismissViewControllerAnimated(false, completion: nil)
        
        if ( bDidAdd ) {            
            sceneMgr.currentProject.people.append( person )
            peopleTableView.reloadData()
            self.onAddNewPerson( self )
        }
 
    }
    func onDismiss(track: Track, bDidAdd: Bool) {
        sceneMgr.mainVC.dismissViewControllerAnimated(false, completion: nil)        
     
        if ( bDidAdd ) {
            sceneMgr.currentProject.addTrack(track)             // use special function to add dependencies to project as well

            peopleTableView.reloadData()
            tracksTableView.reloadData()
            self.onAddNewTrack( self )
        }
    }
    var peopleTableDelegate: PeopleTableDelegate!
    var trackTableDelegate: TrackTableDelegate!
    @IBOutlet weak var tracksTableView: UITableView!
    @IBOutlet weak var peopleTableView: UITableView!
    
    @IBAction func onAddNewPerson(sender: AnyObject) {
        var dialog = DealSetupAddPersonDialog.instanceFromNib(sceneMgr)
            
        dialog.setup( "", project_:sceneMgr.currentProject, delegate_:self, role_: Role.getInstanceOf("Music"), bIsTalent_:false )
        sceneMgr.mainVC.presentViewController(dialog, animated: false, completion: nil)

    }
    @IBAction func onAddNewTrack(sender: AnyObject) {
        var dialog = DealSetupMusicAddTrackDialog.instanceFromNib(sceneMgr, self)
        dialog.dialogListener = self
        
        dialog.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        sceneMgr.mainVC.presentViewController(dialog, animated: false, completion: nil)

    }
    var sceneMgr: AddProjectSceneManager!
    func customInit() {
        self.peopleTableDelegate = PeopleTableDelegate()
        self.trackTableDelegate = TrackTableDelegate()
        
        self.peopleTableView.dataSource = self.peopleTableDelegate
        self.peopleTableView.delegate = self.peopleTableDelegate
        self.peopleTableDelegate.sceneMgr = sceneMgr
        
        self.tracksTableView.dataSource = self.trackTableDelegate
        self.tracksTableView.delegate = self.trackTableDelegate
        self.trackTableDelegate.sceneMgr = sceneMgr
        self.setNeedsDisplay()
    }
    class func instanceFromNib(sceneMgr_:AddProjectSceneManager) -> DealSetupMusicView {
        var newItem = UINib(nibName: "DealSetupMusicView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! DealSetupMusicView
        newItem.sceneMgr = sceneMgr_
        newItem.customInit()
        return newItem
    }
}