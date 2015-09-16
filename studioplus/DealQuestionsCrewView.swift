//
//  DealQuestionsCrewView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/16/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealQuestionsCrewView: UIView, kHackedDropDownListViewDelegate {
    @IBOutlet weak var suppliesDescriptionTextField: UITextField!
    @IBOutlet weak var ownSuppliesSegCtrl: UISegmentedControl!
    @IBOutlet weak var additionalPartiesSegCtrl: UISegmentedControl!
    @IBOutlet weak var selectCrewDropDown: UIButton!
    
    var sceneMgr: AddProjectSceneManager!
    
    class func instanceFromNib() -> DealQuestionsCrewView {
        var newItem = UINib(nibName: "DealQuestionsCrewView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DealQuestionsCrewView
        
        return newItem
    }
    /* dropdownlist code BEGIN */
    func didSelectIndex(anIndex: Int, withId id: String!, inOptions vOptions:[AnyObject]!) {
    }
    func didSelectIndices(indices: [AnyObject]!, withId id: String!,inOptions vOptions:[AnyObject]!) {
        println("selected multiple")
    }
    @IBAction func onShowDropdown(sender: AnyObject) {
        var pos = CGPoint(x:0,y:10)
        var size = CGSize(width:300,height:300)
        
        if ( sceneMgr.currentProject.getPeopleWithRole("Location" ).count > 0 ) {
            var dropObj = DropDownListView(title: "Crew:", options: sceneMgr.currentProject.getPeopleNamesWithRole("Crew"), xy: pos, size: size , isMultiple: true, id: "crew")
            
            dropObj.delegate = self
            dropObj.showInView(self, animated: false)
            dropObj.SetBackGroundDropDwon_R(0.0, g: 108.0, b: 194.0, alpha: 0.70)
        }
    }
    /* dropdownlist code END */

    /*
    func setTemplateValues( deal: Deal ) {
        deal.setTemplateValue(TemplateId.QuestionsWriterProjectApproximateRuntime, value: projectRunTimeTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsWriterApproximateNumPagesInScript, value: numPagesTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsWriterCredit, value: writingCreditTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsWriterNumRevisionsRequired, value:numRevisionsTextField.text)
    }
  */
}