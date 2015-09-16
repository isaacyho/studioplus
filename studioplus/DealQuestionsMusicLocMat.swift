//
//  DealQuestionsMusicLocMat.swift
//  studioplus
//
//  Created by Isaac Ho on 9/16/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealQuestionsMusicLocMat: UIView, TemplateValueHolder {
    class func instanceFromNib() -> DealQuestionsMusicLocMat {
        var newItem = UINib(nibName: "DealQuestionsMusicLocMat", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DealQuestionsMusicLocMat
        
        return newItem
    }
    func setTemplateValues(deal: Deal) {
       // deal.setTemplateValue(TemplateId.QuestionsDirectorRuntime, value: totalRuntimeTextField.text)
    }
  
}
