//
//  Deal.swift
//  studioplus
//
//  Created by Isaac Ho on 9/8/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation

protocol TemplateValueHolder {
    func setTemplateValues( deal: Deal )
}

typealias SnapshotHash = [String:String]

class Deal : PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Deal"
    }

    // template: Template
    @NSManaged var project: Project!
    @NSManaged var snapshotValues:SnapshotHash // template_id, value -- do not set directly!!!! use provided setter
    // signatures: blob
    @NSManaged var signors: [Person] // idx 0 = project owner, 1 = counterparty
    @NSManaged var signatures: [PFFile] // idx 0 = project owner, 1 = counterparty
    @NSManaged var document: PFFile
    var documentIsUserProvided: Bool {
        get { return self["documentIsUserProvided"] as! Bool }
        set { self["documentIsUserProvided"]=newValue    }
    }
    func manualInit() {
        signors = []
        signatures = []
        snapshotValues = [:]
        //document = PFFile()
        documentIsUserProvided = false
    }
    // use this to set template values
    func setTemplateValue( id:TemplateId, value:String ) {
        snapshotValues[ id.id ] = value
    }
    // signing state: computed property
    // - [ new, ownerApproved, sentToSignors, signingComplete, delivered, cancelled ]

}