//
//  DealQuestionsTalentView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/8/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealQuestionsTalentView: UIView, TemplateValueHolder {

    @IBOutlet weak var stageNameTextField: UITextField!
    @IBOutlet weak var episodicSeriesSegControl: UISegmentedControl!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var managerDetailsTextField: UITextField!
    
    @IBOutlet weak var conditionsTextField: UITextField!
    @IBOutlet weak var selectSeasonLabel: UILabel!
    @IBOutlet weak var selectSeasonTextField: UITextField!
    
    @IBOutlet weak var artistFeeTextField: UITextField!
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var paymentTypeTextField: UITextField!
    @IBOutlet weak var numEpisodesByYearTextField: UITextField!
    @IBOutlet weak var numProductionYearsLabel: UILabel!
    @IBOutlet weak var selectEpisodeTextField: UITextField!
    @IBOutlet weak var numProductionYearsTextField: UITextField!
    @IBOutlet weak var selectEpisodeLabel: UILabel!
    @IBOutlet weak var numEpisodesByYearLabel: UILabel!
    class func instanceFromNib() -> DealQuestionsTalentView {
        var newItem = UINib(nibName: "DealQuestionsTalentView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DealQuestionsTalentView
        newItem.onEpisodicSeriesSegControlChange(newItem)
        return newItem
    }
    @IBAction func onEpisodicSeriesSegControlChange(sender: AnyObject) {
        
        var bIsEpisodic = ( episodicSeriesSegControl.selectedSegmentIndex == 0 )
        
        // episodic
        numProductionYearsLabel.hidden = bIsEpisodic
        numProductionYearsTextField.hidden = bIsEpisodic
        numEpisodesByYearLabel.hidden = bIsEpisodic
        numEpisodesByYearTextField.hidden = bIsEpisodic
        
        selectEpisodeLabel.hidden = !bIsEpisodic
        selectEpisodeTextField.hidden = !bIsEpisodic
        selectSeasonLabel.hidden = !bIsEpisodic
        selectSeasonTextField.hidden = !bIsEpisodic
    }

    func setTemplateValues(deal: Deal) {
        var formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        deal.setTemplateValue(TemplateId.QuestionsTalentStageName, value: stageNameTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsTalentPreProductionStartDate, value: formatter.stringFromDate(startDatePicker.date))
        deal.setTemplateValue(TemplateId.QuestionsTalentApproximateEndDate, value: formatter.stringFromDate(endDatePicker.date))
        deal.setTemplateValue(TemplateId.QuestionsTalentPrimaryCity, value: cityTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsTalentAgentDetails, value: managerDetailsTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsTalentAdditionalConditions, value: conditionsTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsTalentSelectEpisode, value: selectEpisodeTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsTalentArtistFee, value: artistFeeTextField.text)
        deal.setTemplateValue(TemplateId.QuestionsTalentPaymentType, value: paymentTypeTextField.text)
    }
}
