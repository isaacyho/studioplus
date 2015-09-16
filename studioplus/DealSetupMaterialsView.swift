//
//  DealSetupMaterialsView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/4/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealSetupMaterialsView: UIView, UITableViewDelegate, UITableViewDataSource, DealSetupAddMaterialDialogListener {
    @IBOutlet weak var materialsTableView: UITableView!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var sceneMgr: AddProjectSceneManager!
    func customInit() {
       self.materialsTableView.dataSource = self
       self.materialsTableView.delegate = self
        
       self.materialsTableView.clipsToBounds = true
       self.setNeedsDisplay()
    }
    func onDismiss(material:Material, bDidAdd: Bool, id:String) {
        sceneMgr.mainVC.dismissViewControllerAnimated(false, completion: nil)
        if ( bDidAdd ) {        
            sceneMgr.currentProject.materials.append(material)
            materialsTableView.reloadData()
            
            self.onAddNewMaterial( self )
        }
    }

    class func instanceFromNib(sceneMgr_:AddProjectSceneManager) -> DealSetupMaterialsView {
        var newItem = UINib(nibName: "DealSetupMaterialsView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! DealSetupMaterialsView
        newItem.sceneMgr = sceneMgr_
        newItem.customInit()
        return newItem
    }
    @IBAction func onAddNewMaterial(sender: AnyObject) {
        var dialog = DealSetupAddMaterialDialog.instanceFromNib(sceneMgr)
        dialog.delegate = self
        dialog.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        sceneMgr.mainVC.presentViewController(dialog, animated: false, completion: nil)
    }
    var selectedIndexPath: NSIndexPath?
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var objects = NSBundle.mainBundle().loadNibNamed("DealSetupMaterialTableCell", owner: self, options: nil)
        var cell = objects[0] as! DealSetupMaterialTableCell
        var p = sceneMgr.currentProject.getPeopleWithRole("Material")[indexPath.row]
        cell.setModel(p, materials_: sceneMgr.currentProject.getMaterialsForPerson(p))
        cell.clipsToBounds = true
        cell.delegate = sceneMgr
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if ( selectedIndexPath == indexPath ) {
            return 120.0
        }
        return 40.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sceneMgr.currentProject.getPeopleWithRole("Material").count
    }

}
