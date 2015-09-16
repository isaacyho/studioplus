//
//  DealSetupAddMaterialDialog.swift
//  studioplus
//
//  Created by Isaac Ho on 9/3/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit
protocol DealSetupAddMaterialDialogListener {
    // id is used if you have more than one dialog sending to same listener; the listener can use it to discriminate which one
    //    to dismiss
    func onDismiss( material:Material, bDidAdd:Bool, id:String )
}

class DealSetupAddMaterialDialog: UIViewController, kHackedDropDownListViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.preferredContentSize = CGSizeMake(700, 700);

    }

    @IBOutlet weak var exclusiveSegControl: UISegmentedControl!
    @IBOutlet weak var feeTextField: UITextField!
    @IBOutlet weak var rentalEndDatePicker: UIDatePicker!
    @IBOutlet weak var rentalStartDatePicker: UIDatePicker!
    @IBOutlet weak var typeSegControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var rentedSegControl: UISegmentedControl!
    
    @IBOutlet weak var ownerSelector: UIButton!
    
    var selectedOwner: Person?
    var sceneMgr: AddProjectSceneManager!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    class func instanceFromNib(sceneMgr_:AddProjectSceneManager) -> DealSetupAddMaterialDialog {

        var newI = UINib(nibName: "DealSetupAddMaterialDialog", bundle: nil)
        
        var newItem = newI.instantiateWithOwner(self, options: nil)[0] as! DealSetupAddMaterialDialog
        newItem.sceneMgr = sceneMgr_
        return newItem
    }
    /* dropdownlist code BEGIN */
    @IBAction func onShowDropdown(sender: AnyObject) {
        var pos = CGPoint(x:0,y:10)
        var size = CGSize(width:300,height:300)
        
        if ( sceneMgr.currentProject.getPeopleWithRole("Material" ).count > 0 ) {
            var dropObj = DropDownListView(title: "Owner:", options: sceneMgr.currentProject.getPeopleNamesWithRole("Material"), xy: pos, size: size , isMultiple: false, id: "owner")
            
            dropObj.delegate = self
            dropObj.showInView(self.view, animated: false)
            dropObj.SetBackGroundDropDwon_R(0.0, g: 108.0, b: 194.0, alpha: 0.70)
        }
   }
    func didSelectIndex(anIndex: Int, withId id: String!, inOptions vOptions:[AnyObject]!) {
        println("selected index: \(anIndex)")
            selectedOwner = sceneMgr.currentProject.getPeopleWithRole("Material")[anIndex]
            ownerSelector.setTitle(selectedOwner?.getName(), forState: UIControlState.Normal)
    }
    func didSelectIndices(indices: [AnyObject]!, withId id: String!, inOptions:[AnyObject]!){
    }
    /* dropdownlist code END */

    
    
    
    var delegate: DealSetupAddMaterialDialogListener! // lazy me
    func returnToDelegate( bDidAdd: Bool) {
        var material = Material()
        material.manualInit()
        if ( bDidAdd ) {
            material.name = titleTextField.text
            material.owner = selectedOwner! // must be selected!
            material.rentalStartDate = rentalStartDatePicker.date
            material.rentalEndDate = rentalEndDatePicker.date
            material.type = Material.MaterialType(rawValue: typeSegControl.selectedSegmentIndex)
            material.descriptionText = descriptionTextField.text
            material.fee = feeTextField.text
            material.bRentedNotPurchased = rentedSegControl.selectedSegmentIndex == 0
            material.bExclusive = exclusiveSegControl.selectedSegmentIndex == 0
        }
        delegate.onDismiss(material, bDidAdd:bDidAdd, id:"")
    }
    
    @IBAction func onAddDone(sender: AnyObject) {
        returnToDelegate(false)
    }
    @IBAction func onAddAnotherMaterial(sender: AnyObject) {
        returnToDelegate(true)
    }

}
