//
//  DealQuestionsCollaboratorTableViewCell.swift
//  studioplus
//
//  Created by Isaac Ho on 9/16/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealQuestionsCollaboratorTableViewCell: UITableViewCell {

    @IBOutlet weak var ownershipLabel: UILabel!
    
    @IBOutlet weak var ownershipStepper: UIStepper!
    
    @IBAction func onOwnershipChange(sender: AnyObject) {
        ownershipLabel.text = "%\(Int(ownershipStepper.value))"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
