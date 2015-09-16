//
//  Location.swift
//  studioplus
//
//  Created by Isaac Ho on 9/3/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
class Location: PFObject, PFSubclassing {
    @NSManaged var name: String
    @NSManaged var owner: Person
    @NSManaged var filmingStartDate: NSDate
    @NSManaged var filmingEndDate: NSDate
    @NSManaged var accessStartDate: NSDate
    @NSManaged var accessEndDate: NSDate
    @NSManaged var address:String
    @NSManaged var fee:String
    @NSManaged var feeType:String
    
    func manualInit() {
        name = ""
        filmingStartDate = NSDate()
        filmingEndDate = NSDate()
        accessStartDate = NSDate()
        accessEndDate = NSDate()
        address = ""
        fee = ""
        feeType = ""
    }
    class func parseClassName() -> String {
        return "Location"
    }
    
}