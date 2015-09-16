//
//  DealSetupMusicAddTrackDialog.swift
//  studioplus
//
//  Created by Isaac Ho on 9/1/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

// whoever presents this dialog should listen
protocol DealSetupMusicAddTrackDialogListener {
    func onDismiss( track:Track, bDidAdd:Bool )
}

/* this dialog will hold a model of:
currently-built track
track points to multiple people as composers ( where role==Music )
track points to multiple people as recording artists ( where role==Music )

XXX Ugh because I'm using instanceFromNib there is no good way to forcibly call init(), even customInit()
    with proper dialogListener
*/

class DealSetupMusicAddTrackDialog: UIViewController,DealSetupAddPersonDialogListener, kHackedDropDownListViewDelegate {
    class ComposerTableDelegate: NSObject,UITableViewDataSource, UITableViewDelegate {
        var sceneMgr:AddProjectSceneManager!
        var dialog:DealSetupMusicAddTrackDialog!
        func customInit( dialog_:DealSetupMusicAddTrackDialog ) {
            dialog = dialog_
        }
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            var objects = NSBundle.mainBundle().loadNibNamed("DealSetupMusicAddTrackComposerTableCell", owner: self, options: nil)
            var cell = objects[0] as! DealSetupMusicAddTrackComposerTableCell
            
            cell.setTrack(dialog.newTrack, composerIdx_: indexPath.row)
            cell.clipsToBounds = true
            return cell
        }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dialog.newTrack.composers.count
        }
    }
    class RecordingArtistTableDelegate: NSObject,UITableViewDataSource, UITableViewDelegate {
        var sceneMgr:AddProjectSceneManager!
        var dialog:DealSetupMusicAddTrackDialog!
        func customInit( dialog_:DealSetupMusicAddTrackDialog ) {
            dialog = dialog_
        }
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            var objects = NSBundle.mainBundle().loadNibNamed("DealSetupMusicAddTrackRecordingArtistTableCell", owner: self, options: nil)
            var cell = objects[0] as! DealSetupMusicAddTrackRecordingArtistTableCell
            
            cell.setTrack(dialog.newTrack, recordingArtistIdx_: indexPath.row)
            cell.clipsToBounds = true

            return cell
        }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dialog.newTrack.recordingArtists.count
        }
    }

    class func instanceFromNib(sceneMgr_:AddProjectSceneManager, DealSetupMusicAddTrackDialogListener) -> DealSetupMusicAddTrackDialog {
        var newItem = UINib(nibName: "DealSetupMusicAddTrackDialog", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! DealSetupMusicAddTrackDialog
        var tableDelegate1 = ComposerTableDelegate()
        var tableDelegate2 = RecordingArtistTableDelegate()
        newItem.customInit(sceneMgr_, composersTableDelegate_: tableDelegate1, recordingArtistsTableDelegate_: tableDelegate2)
        return newItem
    }
    
    /* dropdownlist code BEGIN */
    // we handle both the primary and secondary role dropdowns here
    @IBAction func onSelectComposer(sender: AnyObject) {
        var pos = CGPoint(x:0,y:10)
        var size = CGSize(width:300,height:300)
        if ( sceneMgr.currentProject.getPeopleNamesWithRole("Music").count == 0 ) { return }

        var dropObj = DropDownListView(title: "Composer", options: sceneMgr.currentProject.getPeopleNamesWithRole("Music"), xy: pos, size: size , isMultiple: false, id: "composer")
        
        dropObj.delegate = self
        dropObj.showInView(self.view, animated: false)
        dropObj.SetBackGroundDropDwon_R(0.0, g: 108.0, b: 194.0, alpha: 0.70)
    }
    @IBAction func onSelectRecordingArtist(sender: AnyObject) {
        var pos = CGPoint(x:0,y:10)
        var size = CGSize(width:300,height:300)
        if ( sceneMgr.currentProject.getPeopleNamesWithRole("Music").count == 0 ) { return }
        var dropObj = DropDownListView(title: "Recording Artist", options: sceneMgr.currentProject.getPeopleNamesWithRole("Music"), xy: pos, size: size , isMultiple: false, id: "recording_artist")
        
        dropObj.delegate = self
        dropObj.showInView(self.view, animated: false)
        dropObj.SetBackGroundDropDwon_R(0.0, g: 108.0, b: 194.0, alpha: 0.70)
    }
    
    override func viewDidLoad() {
        self.preferredContentSize = CGSizeMake(700, 700);
    }
    func didSelectIndex(anIndex: Int, withId id: String!, inOptions vOptions:[AnyObject]!) {
        
        println("selected index: \(anIndex)")
        var c = sceneMgr.currentProject.getPeopleWithRole( "Music" )

        if ( id == "composer" ) {
            newTrack.addComposer( c[anIndex] )
            
            composersTableView.reloadData()
        } else if ( id == "recording_artist" ) {
            newTrack.addRecordingArtist( c[anIndex] )
            recordingArtistsTableView.reloadData()
        }
    }
    
    func didSelectIndices(indices: [AnyObject]!, withId id: String!, inOptions vOptions:[AnyObject]!) {
        
    }
    /* dropdownlist code END */
    
    
    
    
    // at this point, person could be either a composer or a recordingArtist
    func onDismiss( person:Person, bDidAdd:Bool, id:String ) {
        self.dismissViewControllerAnimated(false, completion: nil)
        
        if ( bDidAdd ) {
            if ( person.role.name == "Music" ) {
                if ( id == "composer" ) {
                    newTrack.addComposer( person )
                    composersTableView.reloadData()
                    
                    self.onAddNewComposer( self )
                }
                else {
                    newTrack.addRecordingArtist( person )
                    recordingArtistsTableView.reloadData()
                    self.onAddNewRecordingArtist( self )
                }
            }
        }
    }
    var newTrack:Track!
    var dialogListener: DealSetupMusicAddTrackDialogListener!
    var composersTableDelegate:ComposerTableDelegate!
    var recordingArtistsTableDelegate:RecordingArtistTableDelegate!
    var sceneMgr:AddProjectSceneManager!

    @IBOutlet weak var trackNameTextField: UITextField!
    @IBOutlet weak var mediaUsedInTextField: UITextField!
    @IBOutlet weak var territoriesTextField: UITextField!
    @IBOutlet weak var trackLengthTextField: UITextField!
    
    @IBOutlet weak var trackStartTextField: UITextField!
    @IBOutlet weak var trackEndTextField: UITextField!
    @IBOutlet weak var composersTableView: UITableView!
    @IBOutlet weak var recordingArtistsTableView: UITableView!
    
    @IBOutlet weak var composersExclusivitySegControl: UISegmentedControl!
    
    @IBOutlet weak var recordingArtistsExclusivitySegControl: UISegmentedControl!
    
    func returnToDelegate( bDidAdd: Bool) {
        
        // fill up newTrack with values
        newTrack.name = trackNameTextField.text
        newTrack.length = trackLengthTextField.text
        newTrack.trackStart = trackStartTextField.text
        newTrack.trackEnd = trackEndTextField.text
        newTrack.territories = territoriesTextField.text
        newTrack.mediaUsedIn = mediaUsedInTextField.text
        newTrack.bComposersExclusive = composersExclusivitySegControl.selectedSegmentIndex == 0
        newTrack.bRecordingArtistsExclusive = recordingArtistsExclusivitySegControl.selectedSegmentIndex == 0

        // client must manually add composers/recordingartists to the current project if he adds this track to the project
        
        dialogListener.onDismiss(newTrack, bDidAdd:bDidAdd)
    }
    
    @IBAction func onAddNewComposer(sender: AnyObject) {
        var dialog = DealSetupAddPersonDialog.instanceFromNib(sceneMgr)

        dialog.setup("composer", project_:sceneMgr.currentProject,delegate_: self, role_: Role.getInstanceOf("Music"),bIsTalent_:false)
        self.presentViewController(dialog, animated: false, completion: nil)
    }
    @IBAction func onDone(sender: AnyObject) {
        returnToDelegate(false)
    }
    @IBAction func onAddAnotherTrack(sender: AnyObject) {
        returnToDelegate(true)
    }
    @IBAction func onAddNewRecordingArtist(sender: AnyObject) {
        var dialog = DealSetupAddPersonDialog.instanceFromNib(sceneMgr)
     
        dialog.setup( "recordingArtist", project_:sceneMgr.currentProject, delegate_:self, role_: Role.getInstanceOf("Music"), bIsTalent_:false )
        self.presentViewController(dialog, animated: false, completion: nil)
    }
    
    // must call this b/c I dunno how to force this to be called
    //   using nib initialization
    func customInit( sceneMgr_: AddProjectSceneManager, composersTableDelegate_: ComposerTableDelegate,
        recordingArtistsTableDelegate_: RecordingArtistTableDelegate) {
        sceneMgr = sceneMgr_
        composersTableDelegate=composersTableDelegate_
        recordingArtistsTableDelegate=recordingArtistsTableDelegate_
            
        composersTableView.delegate = composersTableDelegate
        composersTableView.dataSource = composersTableDelegate
        composersTableDelegate.sceneMgr = sceneMgr_
        recordingArtistsTableView.delegate = recordingArtistsTableDelegate
        recordingArtistsTableView.dataSource = recordingArtistsTableDelegate
        recordingArtistsTableDelegate.sceneMgr = sceneMgr_
        self.view.setNeedsDisplay()
            
        composersTableDelegate.customInit( self )
        recordingArtistsTableDelegate.customInit( self )

        newTrack = Track()
        newTrack.manualInit()
    }
    
    

    
}