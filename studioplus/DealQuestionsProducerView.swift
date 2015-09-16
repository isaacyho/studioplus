//
//  DealQuestionsProducerView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/16/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealQuestionsProducerView: UIView, TemplateValueHolder {
    class func instanceFromNib() -> DealQuestionsProducerView {
        var newItem = UINib(nibName: "DealQuestionsProducerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DealQuestionsProducerView
        
        return newItem
    }
    func setTemplateValues(deal: Deal) {
      //  deal.setTemplateValue(TemplateId.QuestionsDirectorRuntime, value: totalRuntimeTextField.text)
    }
    
}
