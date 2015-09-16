//
//  Role.swift
//  studioplus
//
//  Created by Isaac Ho on 9/1/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation


/* In our system, role objects are compared by looking at their typeIdx.  
   For efficiency we may reuse the same role objects for various people, for instance,
      but this is not required.  TypeIdx equality is the standard for logical equality
      between Role objects.

  should this just be an enum type?
   NO b/c Parse may crap out storing enums
     and it's not extensible in the db
*/
class Role: PFObject, PFSubclassing {
    var typeIdx: Int
    var name: String
    static var instances:[Role] = []
    static var typeLabels:[String] = []
    
    // useful type subsets: can check spelling in init()
    static var talentLabels:[String] = []
    
    init( typeIdx_: Int ) {
        typeIdx = typeIdx_
        name = Role.typeLabels[typeIdx]
        super.init()
    }
    class func parseClassName() -> String {
        return "Role"
    }
    func isTalent() -> Bool {
        return contains(Role.talentLabels, name )
    }
    
    // XXX - workaround for swift bug not initing class vars right away
    class func classCustomInit() {
        typeLabels = ["Actor","Collaborator","Crew","Director","Extra","Producer","GuestStar","Host", "VoiceOver","Writer","Music","Location","Material","Photographer","PostProduction","Distribution","Sponsorship","ProductIntegration", "None", "Owner"]  // None and Owner I added myself
        talentLabels =
            ["Actor", "Crew", "Director", "Extra", "Producer", "GuestStar", "Host", "VoiceOver", "Writer", "Photographer", "PostProduction"]
        for ( var i = 0; i < typeLabels.count; i++ ) {
            instances.append( Role(typeIdx_: i) )
        }
        
    }
    func isEqualTo( var x:String ) -> Bool {
        return Role.typeLabels[typeIdx] == x
    }
    class func getTalentLabels() -> [String] {
        return talentLabels
    }
    
    // converts scripted type label list to unscripted
    class func makeUnscripted( oldTypeLabels:[String]) ->[String] {
        var newTypeLabels = oldTypeLabels
        
        let i = find(newTypeLabels,"Actor")
        if ( i >= 0 && i < newTypeLabels.count ) {
            newTypeLabels.removeAtIndex(i!)
        }
        return newTypeLabels
    }
    class func getInstanceOf(label:String) -> Role? {
        for ( var i = 0; i < typeLabels.count; i++ ) {
            if ( typeLabels[i] == label ) {
                return getInstanceWithIdx( i )
            }
        }
        return nil
    }
    func getLabel() -> String {
        return Role.typeLabels[typeIdx]
    }
    class func getInstanceWithIdx(idx: Int ) -> Role? {
        if ( idx < 0 || idx >= instances.count ) { return nil }
        
        return instances[idx]
    }
    class func getTypeLabels() -> [ String ]  {
        return typeLabels
    }
}