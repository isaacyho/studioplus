//
//  DealSetupAddLocationTableCell.swift
//  studioplus
//
//  Created by Isaac Ho on 9/4/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealSetupAddLocationTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var detailsTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onMakeDeal(sender: AnyObject) {
        delegate.onMakeDeal(owner)
    }
    
    // don't set these directly, use setModel()
    var owner: Person!
    var locations: [Location]!
    var delegate: MakeDealListener!
    
    func setModel( owner_:Person, locations_:[Location]) {
        owner = owner_
        locations = locations_
        
        nameLabel.text = "\(owner.getName()) (\(locations.count) locations)"
        var text = ""
        for l in locations {
            text += "\(l.address) Access dates: \(l.accessStartDate) - \(l.accessEndDate)  Fee: \(l.fee) \(l.feeType)\n"
        }
        detailsTextView.text = text
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
