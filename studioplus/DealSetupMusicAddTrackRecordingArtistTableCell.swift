//
//  DealSetupMusicAddTrackRecordingArtistTableCell.swift
//  studioplus
//
//  Created by Isaac Ho on 9/6/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealSetupMusicAddTrackRecordingArtistTableCell: UITableViewCell {

    @IBOutlet weak var recordingArtistNameLabel: UILabel!
    @IBOutlet weak var ownershipPctLabel: UILabel!
    @IBOutlet weak var ownershipPctStepper: UIStepper!
    var track:Track!
    var recordingArtistIdx:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setTrack( t:Track, recordingArtistIdx_:Int ){
        track=t; recordingArtistIdx=recordingArtistIdx_
        
        recordingArtistNameLabel.text = track.recordingArtists[recordingArtistIdx].getName()
        ownershipPctStepper.value = track.recordingArtistsOwnershipPcts[recordingArtistIdx]
        
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
