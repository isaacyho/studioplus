//
//  DealQuestionsPerformerView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/16/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealQuestionsPerformerView: UIView, TemplateValueHolder {
    @IBOutlet weak var characterTextField: UITextField!
    @IBOutlet weak var primaryPlaceTextField: UITextField!
    
    class func instanceFromNib() -> DealQuestionsPerformerView {
        var newItem = UINib(nibName: "DealQuestionsPerformerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DealQuestionsPerformerView
        
        return newItem
    }
    func setTemplateValues(deal: Deal) {
        deal.setTemplateValue(TemplateId.QuestionsPerformerCharacter, value: characterTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsPerformerPrimaryPlace, value: primaryPlaceTextField.text)
    }
   
}
