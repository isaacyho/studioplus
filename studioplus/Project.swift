//
//  Project.swift
//  studioplus
//
//  Created by Isaac Ho on 8/31/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
class Project: PFObject, PFSubclassing,TemplateValueHolder {
    @NSManaged var name: String
    @NSManaged var people:[Person] // all people, incl both talent + nontalent
    @NSManaged var materials:[Material]
    @NSManaged var tracks:[Track]
    @NSManaged var locations:[Location]
   
    var bIsSingleProject: Bool {
        get { return self["bIsSingleProject"] as! Bool }
        set { self["bIsSingleProject"] = newValue }
    }
    var bIsScripted: Bool {
        get { return self["bIsScripted"] as! Bool }
        set { self["bIsScripted"] = newValue }
    }
    @NSManaged var title: String
    @NSManaged var tags: String
    @NSManaged var numCollaborators:Int
    @NSManaged var startDate: NSDate
    @NSManaged var endDate: NSDate
    @NSManaged var numEpisodes: Int
    @NSManaged var videoLink: String
    @NSManaged var publicProfileName: String
    @NSManaged var tagLine: String
    @NSManaged var mediaTypes: String  // comma-separated text list
    @NSManaged var totalNumberProductionYears: Int
    @NSManaged var descriptionText: String // description is an NSObject keyword
    
    // must manually call this init function for new objects ( parse doesn't allow overriding init )
    func manualInit() {
        name = ""
        people = []
        materials = []
        tracks = []
        locations=[]
        bIsSingleProject = false
        bIsScripted = false
        title = ""
        tags = ""
        numCollaborators = 0
        startDate = NSDate()
        endDate = NSDate()
        numEpisodes = 0
        videoLink = ""
        publicProfileName = ""
        tagLine = ""
        mediaTypes = ""
    }
    class func parseClassName() -> String {
        return "Project"
    }
    func getLocationsForPerson( p: Person ) -> [Location]{
        var locs:[Location] = [];
        for l in locations {
            if ( l.owner == p ) {
                locs.append( l )
            }
        }
        return locs
    }
    func getMaterialsForPerson( p: Person ) -> [Material] {
        var mats:[Material] = [];
        for m in materials {
            if ( m.owner == p ) {
                mats.append( m )
            }
        }
        return mats
    }
    
    func setTemplateValues( deal:Deal )  {
     //   deal.setTemplateValue() do this a bunch for your model
        deal.setTemplateValue( TemplateId.ProjectTitle, value: title )
        deal.setTemplateValue( TemplateId.ProjectLogo, value: "" )
        deal.setTemplateValue( TemplateId.ProjectNumCreators, value: "\(numCollaborators)" )
        deal.setTemplateValue( TemplateId.ProjectIsScripted, value: (bIsScripted ? "scripted" : "unscripted") )
        deal.setTemplateValue( TemplateId.ProjectIsEpisodic, value: (!bIsSingleProject ? "episodic" : "single project") )
    }
    // return value:
    // - track
    // - string - role label for what is my role for the track
    // - int ( what is my index in the parallel arrays [ composer vs. recording artist ] in the track )
    typealias TrackRelationship = (track:Track,role:String,idx:Int)

    func getTracksForPerson( p: Person ) -> [TrackRelationship] {
        var tracksAndRoles:[TrackRelationship] = []
        for t in tracks {
            for ( var cIdx = 0; cIdx < t.composers.count; cIdx++ ) {
                if ( t.composers[cIdx] == p ) {
                    var val:TrackRelationship = (t,"Composer",cIdx)
                    tracksAndRoles.append( val )
                }
            }
        }
        return tracksAndRoles
    }
    
    // once we inherit from NSObject and Parse this should work fine
    func addPersonIfNotPresent( p: Person ) {
        for i in people {
            if ( p == i ) { return }
        }
        people.append( p )
    }
    func addTrack( t: Track ) {
        tracks.append( t )
        for c in t.composers {
            addPersonIfNotPresent(c )
        }
        for r in t.recordingArtists {
            addPersonIfNotPresent(r)
        }
    }
    func getPeopleNamesWithRole( roleType: String ) -> [String] {
        var names: [String] = []
        
        for i in getPeopleWithRole( roleType ) {
            names.append( i.getName() )
        }
        return names
    }
    func getPeopleWithRole( roleType:String ) -> [Person] {
        var rolePeople: [Person] = []
    
        for p in people {
            if ( roleType == "Talent" && p.role.isTalent() ||
              ( p.role.isEqualTo( roleType ) ) ) {
                rolePeople.append( p )
            }
        }
        return rolePeople
    }
    
}
