//
//  DummyDeal.swift
//  studioplus
//
//  Created by Isaac Ho on 9/9/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
class DummyDeal : PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "DummyDeal"
    }
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    // template: Template
    //var project: Project!
    //@NSManaged var name:String
    @NSManaged var snapshotValues:[String:String] // template_id, value
    @NSManaged var document:PFFile
    
    // signatures: blob
    //var signors: [Person] = [] // idx 0 = project owner
    // document: blob
    //var documentBuffer:
    //var bUserGenerated: Bool!
    //var bUserGeneratedFullySigned: Bool!
    
    // signing state: computed property
    // - [ new, ownerApproved, sentToSignors, signingComplete, delivered, cancelled ]
    
}