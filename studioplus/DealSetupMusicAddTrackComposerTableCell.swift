//
//  DealSetupMusicAddTrackComposerTableCell.swift
//  studioplus
//
//  Created by Isaac Ho on 9/6/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealSetupMusicAddTrackComposerTableCell: UITableViewCell {
    @IBOutlet weak var composerNameLabel: UILabel!
    @IBOutlet weak var ownershipPctLabel: UILabel!
    @IBOutlet weak var ownershipPctStepper: UIStepper!
    var track:Track!
    var composerIdx:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // composerIdx - the index in the parallel arrays of Track for the person of interest
    func setTrack( t:Track, composerIdx_:Int ){
        track=t; composerIdx=composerIdx_
        
        composerNameLabel.text = track.composers[composerIdx].getName()
        ownershipPctStepper.value = track.composersOwnershipPcts[composerIdx]

        onOwnershipPctChanged(ownershipPctStepper)
    }
    @IBAction func onOwnershipPctChanged(sender: AnyObject) {
        ownershipPctLabel.text = String(format:"%.1f", ownershipPctStepper.value)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
