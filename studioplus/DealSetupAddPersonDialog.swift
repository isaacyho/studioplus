//
//  DealSetupAddAssetDialog.swift
//  studioplus
//
//  Created by Isaac Ho on 9/1/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

protocol DealSetupAddPersonDialogListener {
    // id is used if you have more than one dialog sending to same listener; the listener can use it to discriminate which one
    //    to dismiss
    func onDismiss( person:Person, bDidAdd:Bool, id:String )
}


/*

BEWARE:
- trickiness when using array indices and Roles, since we are often asked to use a subset of the full list of Roles.  Always be clear which index system you are referring to...the full set of roles, or some custom subset?  For safety, given a roleLabel just 
    use the Role.getInstanceOf() to find the correct role object, rather than relying on
    the index being parallel to some array of Roles.
*/

class DealSetupAddPersonDialog : UIViewController, kHackedDropDownListViewDelegate {

    class func instanceFromNib(sceneMgr_:AddProjectSceneManager) -> DealSetupAddPersonDialog {
        var newItem = UINib(nibName: "DealSetupAddPersonDialog", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! DealSetupAddPersonDialog
        newItem.setCategory( Person.Category.Person )
        return newItem
    }
    var id: String = "" // hacky way of allowing a single DealSetupAddPersonDialogListener to handle multiple dialogs;
    
    var project:Project!//  the id is used by the listener to discriminate bt them
    var bIsTalent:Bool!
    var delegate: DealSetupAddPersonDialogListener! // lazy me
    func setCategory( category: Person.Category ) {
        switch( category ) {
        case .Person:
            typeSegmentedControl.selectedSegmentIndex = 0
            companyNameLabel.hidden = true
            companyNameTextField.hidden = true
            bandNameLabel.hidden = true
            bandNumberMembersLabel.hidden = true
            bandNameTextField.hidden = true
            bandNumberMembersTextField.hidden = true
        case .Company:
            typeSegmentedControl.selectedSegmentIndex = 1
            companyNameLabel.hidden = false
            companyNameTextField.hidden = false
            bandNameLabel.hidden = true
            bandNameTextField.hidden = true
            bandNumberMembersTextField.hidden = true
            bandNumberMembersLabel.hidden = true
        case .Band:
            typeSegmentedControl.selectedSegmentIndex = 2
            companyNameLabel.hidden = true
            companyNameTextField.hidden = true
            bandNameLabel.hidden = false
            bandNumberMembersLabel.hidden = false
            bandNameTextField.hidden = false
            bandNumberMembersTextField.hidden = false
            
        }
    }
    // This is the entry point callers should be using.  Used to optionally select primary role and set invariants based off it
    func setup( id_: String,  project_:Project,delegate_: DealSetupAddPersonDialogListener, role_: Role?, bIsTalent_: Bool) {
        self.modalPresentationStyle = UIModalPresentationStyle.FormSheet

        id = id_
        // enable/disable based on role
        delegate = delegate_
        bIsTalent = bIsTalent_
        project=project_
        
        if ( role_ != nil ) {
            primaryRoleSelector.enabled = false
            selectedPrimaryRole = role_!
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        onAgeChanged( ageStepper )
        
        // allow the caller to pre-set these roles
        if ( selectedPrimaryRole == nil ) {
            selectedPrimaryRole = Role.getInstanceOf("None")
        }
        if ( selectedSecondaryRole == nil ) {
            selectedSecondaryRole = Role.getInstanceOf("None")
        }
        var optionsHolder = []
        
        didSelectIndex( selectedPrimaryRole.typeIdx, withId: "primary_role",inOptions:Role.getTypeLabels())
        didSelectIndex( selectedSecondaryRole.typeIdx, withId: "secondary_role",inOptions:Role.getTypeLabels() )

        self.preferredContentSize = CGSizeMake(500, 700);
        self.onAgeChanged(ageStepper)
        
    }
    
    var selectedPrimaryRole:Role!
    var selectedSecondaryRole:Role!
    
    @IBOutlet weak var primaryRoleSelector: UIButton!
    @IBOutlet weak var secondaryRoleSelector: UIButton!
    
    /* dropdownlist code BEGIN */
    // we handle both the primary and secondary role dropdowns here
    @IBAction func onPrimaryRoleSelect(sender: AnyObject) {
        var pos = CGPoint(x:0,y:10)
        var size = CGSize(width:300,height:300)
        
        var roleTypeLabels = ( bIsTalent == true ? Role.getTalentLabels() : Role.getTypeLabels() )
        
        if ( !project.bIsScripted ) {
            Role.makeUnscripted(roleTypeLabels)
        }
        
        var dropObj = DropDownListView(title: "Role", options: roleTypeLabels, xy: pos, size: size , isMultiple: false, id: "primary_role")
        
        dropObj.delegate = self
        dropObj.showInView(self.view, animated: false)
        dropObj.SetBackGroundDropDwon_R(0.0, g: 108.0, b: 194.0, alpha: 0.70)
    }
    @IBAction func onSecondaryRoleSelect(sender: AnyObject) {
        var pos = CGPoint(x:0,y:10)
        var size = CGSize(width:300,height:300)
        
        var roleTypeLabels = ( bIsTalent == true ? Role.getTalentLabels() : Role.getTypeLabels() )
        
        if ( !project.bIsScripted ) {
            Role.makeUnscripted(roleTypeLabels)
        }
        // remove currently selected primary role
        if ( selectedPrimaryRole != nil ) {
            let i = find(roleTypeLabels,selectedPrimaryRole.getLabel())!
            if ( i>=0 && i<roleTypeLabels.count) {
                roleTypeLabels.removeAtIndex(i)
            }
        }
        var dropObj = DropDownListView(title: "Role", options: roleTypeLabels, xy: pos, size: size , isMultiple: false, id: "secondary_role")
        
        dropObj.delegate = self
        dropObj.showInView(self.view, animated: false)
        dropObj.SetBackGroundDropDwon_R(0.0, g: 108.0, b: 194.0, alpha: 0.70)
    }

    
    func didSelectIndex(anIndex: Int, withId id: String!, inOptions vOptions:[AnyObject]!) {
        
        println("selected index: \(anIndex)")
        var selectedLabel = vOptions[anIndex] as! String
        
        if ( id == "primary_role" ) {
            selectedPrimaryRole = Role.getInstanceOf(selectedLabel)
            primaryRoleSelector.setTitle(selectedLabel, forState: UIControlState.Normal)
        } else if ( id == "secondary_role" ) {
            selectedSecondaryRole = Role.getInstanceOf(selectedLabel)
            secondaryRoleSelector.setTitle(selectedLabel, forState: UIControlState.Normal)
        }
    }
    
    func didSelectIndices(indices: [AnyObject]!, withId id: String!, inOptions vOptions:[AnyObject]!) {
        
    }
    /* dropdownlist code END */

    
    @IBOutlet weak var relationshipSegControl: UISegmentedControl!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var rolePicker: UIPickerView!
    @IBOutlet weak var roleDetailsTextField: UITextField!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var personAgeLabel: UILabel!
    @IBOutlet weak var personParentNameTextField: UITextField!
    @IBOutlet weak var personParentEmailTextField: UITextField!
    
    @IBOutlet weak var ageStepper: UIStepper!
    // conditional, based on selected type
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var personParentNameLabel: UILabel!
    @IBOutlet weak var bandNameLabel: UILabel!
    @IBOutlet weak var bandNumberMembersLabel: UILabel!
    @IBOutlet weak var personParentEmailLabel: UILabel!
    @IBOutlet weak var bandNameTextField: UITextField!
    @IBOutlet weak var bandNumberMembersTextField: UITextField!
    @IBOutlet weak var relationshipPicker: UIPickerView!
    
    @IBOutlet weak var relationshipLabel: UILabel!
    @IBAction func onTypeChanged(sender: AnyObject) {
        setCategory( Person.Category(rawValue: typeSegmentedControl.selectedSegmentIndex)! )
    }
  
    
    @IBAction func onAgeChanged(sender: UIStepper) {
        personAgeLabel.text =  Int(sender.value).description
        var bIsAdult = personAgeLabel.text!.toInt() >= 21
        
        personParentNameLabel.hidden = bIsAdult
        personParentEmailTextField.hidden = bIsAdult
        personParentNameTextField.hidden = bIsAdult
        personParentEmailLabel.hidden = bIsAdult
        relationshipLabel.hidden = bIsAdult
        relationshipPicker.hidden = bIsAdult
    }
    enum Relationships:Int {
        case Father, Mother, Guardian
    }
    let relationshipLabels = ["Father","Mother","Guardian"]

    
    func returnToDelegate( bDidAdd: Bool) {
        var person = Person()
        person.manualInit()
        // fill with props
        
        // validate first before building + handing back new object
        if ( bDidAdd && ( selectedPrimaryRole == nil || selectedPrimaryRole.getLabel() == "None" )) {
            Settings.sharedInstance.showError("valid primary role required", masterVC: self)
            return
        }

        
        person.role = selectedPrimaryRole
        person.secondaryRole = selectedSecondaryRole
        person.firstName = firstNameTextField.text
        person.lastName = lastNameTextField.text
        person.roleDetails = roleDetailsTextField.text
        person.phoneNumber = phoneNumberTextField.text
        person.email = emailTextField.text
        person.address = addressTextField.text
        person.companyName = companyNameTextField.text
        
        person.age = 0
        if let x = personAgeLabel.text!.toInt() {
            person.age = x
        }
        
        person.parentName = personParentNameLabel.text!
        person.parentEmail = personParentEmailTextField.text
        person.bandName = bandNameTextField.text
        
        person.bandNumberMembers = 0
        if let x = bandNumberMembersTextField.text!.toInt() {
            person.bandNumberMembers = x
        }
        person.role = selectedPrimaryRole
        person.secondaryRole = selectedSecondaryRole
        person.parentRelationship = relationshipLabels[relationshipSegControl.selectedSegmentIndex]
        
        delegate.onDismiss(person, bDidAdd:bDidAdd, id:self.id)
    }
    
    @IBAction func onAddAnotherPerson(sender: AnyObject) {
        returnToDelegate(true)
         }
    
    @IBAction func onDone(sender: AnyObject) {
      returnToDelegate(false)
    }
    
}