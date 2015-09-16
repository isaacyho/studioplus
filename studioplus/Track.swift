//
//  Track.swift
//  studioplus
//
//  Created by Isaac Ho on 9/1/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation

class Track: PFObject, PFSubclassing, TemplateValueHolder {
    @NSManaged var name:String
    @NSManaged var length:String
    @NSManaged var trackStart:String
    @NSManaged var trackEnd:String
    @NSManaged var territories:String
    @NSManaged var mediaUsedIn:String
    var bComposersExclusive: Bool {
        get { return self["bComposersExclusive"] as! Bool }
        set { self["bComposersExclusive"] = newValue }
    }
    var bRecordingArtistsExclusive: Bool {
        get { return self["bRecordingArtistsExclusive"] as! Bool }
        set { self["bRecordingArtistsExclusive"] = newValue }
    }
    // parallel arrays
    @NSManaged var composers:[Person]
    @NSManaged var composersOwnershipPcts:[Double]
    @NSManaged var composersFees:[Double]
    
    @NSManaged var recordingArtists:[Person]
    @NSManaged var recordingArtistsOwnershipPcts:[Double]
    @NSManaged var recordingArtistsFees:[Double]

    func manualInit() {
        name = ""
        length = ""
        trackStart = ""
        trackEnd = ""
        territories = ""
        mediaUsedIn = ""
        bComposersExclusive = false
        bRecordingArtistsExclusive = false
        composers = []
        composersOwnershipPcts = []
        composersFees = []
        recordingArtists = []
        recordingArtistsOwnershipPcts = []
        recordingArtistsFees = []
    }
    static func parseClassName() -> String {
        return "Track"
    }
    
    // These will need to be associated with the parent project externally
    func addComposer( c:Person ) {
        assert( c.role.name == "Music" )
        
        composers.append( c )
        composersFees.append( 0.0 )
        composersOwnershipPcts.append( 0.0 )
    }
    // These will need to be associated with the parent project externally
    func addRecordingArtist( c:Person ) {
        assert( c.role.name == "Music" )
        recordingArtists.append( c )
        recordingArtistsFees.append( 0.0 )
        recordingArtistsOwnershipPcts.append( 0.0 )
    }
    func setTemplateValues(deal: Deal) {
        
    }
}