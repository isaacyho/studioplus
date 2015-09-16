//
//  DealSetupAddLocationDialog.swift
//  studioplus
//
//  Created by Isaac Ho on 9/3/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

protocol DealSetupAddLocationDialogListener {
    // id is used if you have more than one dialog sending to same listener; the listener can use it to discriminate which one
    //    to dismiss
    // NOTE: if bDidAdd is false, the location object returned may be invalid/incompletely built!  Client should ignore this value ( I should really 
    //  create a separate method for this case in the protocol huh )
    func onDismissLocationDialog( location:Location, bDidAdd:Bool, id:String )
}

class DealSetupAddLocationDialog: UIViewController, kHackedDropDownListViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.preferredContentSize = CGSizeMake(700, 700);

    }
    @IBOutlet weak var filmingEndDatePicker: UIDatePicker!

    @IBOutlet weak var ownerSelector: UIButton!
    @IBOutlet weak var feeTypeSegControl: UISegmentedControl!
    @IBOutlet weak var feeTextField: UITextField!
    @IBOutlet weak var accessEndDatePicker: UIDatePicker!
    @IBOutlet weak var filmingStartDatePicker: UIDatePicker!
    @IBOutlet weak var accessStartDatePicker: UIDatePicker!
    @IBOutlet weak var addressTextField: UITextField!
    
    var selectedOwner: Person?
    var feeTypeLabels = ["Flat Fee", "Per Day", "Per Week", "Per Hour"]
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    class func instanceFromNib(sceneMgr_:AddProjectSceneManager) -> DealSetupAddLocationDialog{
        var newItem = UINib(nibName: "DealSetupAddLocationDialog", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! DealSetupAddLocationDialog
        // do any custominit stuff here on the item
        newItem.sceneMgr = sceneMgr_
        
        return newItem
    }
    
    /* dropdownlist code BEGIN */
    func didSelectIndex(anIndex: Int, withId id: String!, inOptions vOptions:[AnyObject]!) {
        println("selected index: \(anIndex)")
        if ( id == "owner") {
            selectedOwner = sceneMgr.currentProject.getPeopleWithRole("Location")[anIndex]
            ownerSelector.setTitle(selectedOwner?.getName(), forState: UIControlState.Normal)
        }
    }
    func didSelectIndices(indices: [AnyObject]!, withId id: String!,inOptions vOptions:[AnyObject]!) {
    }
    @IBAction func onShowDropdown(sender: AnyObject) {
       var pos = CGPoint(x:0,y:10)
        var size = CGSize(width:300,height:300)
        
        if ( sceneMgr.currentProject.getPeopleWithRole("Location" ).count > 0 ) {
        var dropObj = DropDownListView(title: "Owner:", options: sceneMgr.currentProject.getPeopleNamesWithRole("Location"), xy: pos, size: size , isMultiple: false, id: "owner")
        
        dropObj.delegate = self
        dropObj.showInView(self.view, animated: false)
        dropObj.SetBackGroundDropDwon_R(0.0, g: 108.0, b: 194.0, alpha: 0.70)
        }
    }
    /* dropdownlist code END */
    
    // This is the entry point callers should be using.  
    func setup( delegate_: DealSetupAddLocationDialogListener) {
        self.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        
        // enable/disable based on role
        delegate = delegate_
    }

    
    
    func returnToDelegate( bDidAdd: Bool) {
        var location = Location()
        location.manualInit()
        if ( bDidAdd ) {
            location.address = addressTextField.text
            location.filmingStartDate = filmingStartDatePicker.date
            location.filmingEndDate = filmingEndDatePicker.date
            location.accessStartDate = accessStartDatePicker.date
            location.accessEndDate = accessEndDatePicker.date
            location.fee = feeTextField.text
            location.owner = selectedOwner!
            location.feeType = feeTypeLabels[ feeTypeSegControl.selectedSegmentIndex ]
        }
        // feeType
        delegate.onDismissLocationDialog(location, bDidAdd:bDidAdd, id:"")
    }
    var sceneMgr: AddProjectSceneManager!
    var delegate: DealSetupAddLocationDialogListener!
    
    
    @IBAction func onDone(sender: AnyObject) {
        returnToDelegate(false)
    }
    @IBAction func onAddAnotherLocation(sender: AnyObject) {
        returnToDelegate(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
