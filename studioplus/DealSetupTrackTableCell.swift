//
//  DealSetupTrackTableCell.swift
//  studioplus
//
//  Created by Isaac Ho on 9/1/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealSetupTrackTableCell: UITableViewCell {

    @IBOutlet weak var trackNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var track: Track!
    func setModel( t: Track ) {
        track = t
        
        var text = "\(track.name) [\(track.trackStart) - \(track.trackEnd) ] / (track.length)"
        trackNameLabel.text = text
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
