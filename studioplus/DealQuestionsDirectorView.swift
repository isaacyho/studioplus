//
//  DealQuestionsDirectorView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/16/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealQuestionsDirectorView: UIView, TemplateValueHolder {
    
    @IBOutlet weak var episodesRuntimeTextField: UITextField!
    @IBOutlet weak var totalRuntimeTextField: UITextField!
    class func instanceFromNib() -> DealQuestionsDirectorView {
        var newItem = UINib(nibName: "DealQuestionsDirectorView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DealQuestionsDirectorView
        
        return newItem
    }
    func setTemplateValues(deal: Deal) {
        deal.setTemplateValue(TemplateId.QuestionsDirectorRuntime, value: totalRuntimeTextField.text)
    }
}
