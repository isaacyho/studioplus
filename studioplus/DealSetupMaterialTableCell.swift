//
//  DealSetupMaterialTableCell.swift
//  studioplus
//
//  Created by Isaac Ho on 9/4/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealSetupMaterialTableCell: UITableViewCell {
    var owner: Person!
    var materials: [Material]!
    var delegate: MakeDealListener!
    
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func onMakeDeal(sender: AnyObject) {
        delegate.onMakeDeal(owner)
    }
    func setModel( owner_:Person, materials_:[Material]) {
        materials = materials_
        owner = owner_
        nameLabel.text = "\(owner.getName()) (\(materials.count) materials)"
        var text = ""
        for l in materials {
            text += "\(l.name) Category:\(l.getTypeLabel())  Fee: \(l.fee) \(l.feeType)\n"
        }
        detailsTextView.text = text
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
