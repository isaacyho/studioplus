//
//  DealQuestionsPostProductionView.swift
//  
//
//  Created by Isaac Ho on 9/16/15.
//
//

import UIKit

class DealQuestionsPostProductionView: UIView, TemplateValueHolder {
    @IBOutlet weak var creditDropDown: UIButton!
    
    class func instanceFromNib() -> DealQuestionsPostProductionView {
        var newItem = UINib(nibName: "DealQuestionsPostProductionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DealQuestionsPostProductionView
        
        return newItem
    }
    func setTemplateValues(deal: Deal) {
        //deal.setTemplateValue(TemplateId.QuestionsDirectorRuntime, value: totalRuntimeTextField.text)
    }
}
