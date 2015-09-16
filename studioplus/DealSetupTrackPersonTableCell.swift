//
//  DealSetupTrackPersonTableCell.swift
//  studioplus
//
//  Created by Isaac Ho on 9/7/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealSetupTrackPersonTableCell: UITableViewCell {

    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var numTracksLabel: UILabel!
    
    var delegate:MakeDealListener!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var person: Person!
    var trackRelationships: [Project.TrackRelationship]!
    
    func setModel( p: Person, t:[Project.TrackRelationship]){
        person = p
        trackRelationships = t

        personNameLabel.text = p.getName()
        numTracksLabel.text = "(\(t.count) tracks)"
        var text = ""
        for tr in trackRelationships {
            var fee = "(fee)"
            if ( tr.role == "Composer" ) {
                fee = "\(tr.track.composersFees[ tr.idx ])"
            }
            if ( tr.role == "RecordingArtist" ) {
                fee = "\(tr.track.recordingArtistsFees[ tr.idx ])"
            }
            text += ":\(tr.track.name) \(tr.role) \(fee)\n"
            
            text += "   Length: \(tr.track.trackStart) - \(tr.track.trackEnd) / \(tr.track.length)\n"
            text += "   Territory: \(tr.track.territories)  Medium: \(tr.track.mediaUsedIn)\n"
        }
        detailsTextView.text = text
    }
    @IBAction func onMakeDeal(sender: AnyObject) {
        delegate.onMakeDeal(person!)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
