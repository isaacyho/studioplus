//
//  DealQuestionsWriterView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/9/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation

class DealQuestionsWriterView: UIView, TemplateValueHolder {
    @IBOutlet weak var projectRunTimeTextField: UITextField!
    @IBOutlet weak var episodesRunTimeTextField: UITextField!
    @IBOutlet weak var numPagesTextField: UITextField!
    
    @IBOutlet weak var writingCreditTextField: UITextField!
    @IBOutlet weak var numRevisionsTextField: UITextField!
    @IBOutlet weak var writingCreditOtherTextField: UITextField!
    
    class func instanceFromNib() -> DealQuestionsWriterView {
        var newItem = UINib(nibName: "DealQuestionsWriterView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DealQuestionsWriterView
        
        return newItem
    }

    func setTemplateValues( deal: Deal ) {
        deal.setTemplateValue(TemplateId.QuestionsWriterProjectApproximateRuntime, value: projectRunTimeTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsWriterApproximateNumPagesInScript, value: numPagesTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsWriterCredit, value: writingCreditTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsWriterNumRevisionsRequired, value:numRevisionsTextField.text)
    }
}