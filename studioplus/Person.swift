//
//  Asset.swift
//  studioplus
//
//  Created by Isaac Ho on 9/1/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation

// actually it can be of category: Person/Band/Company
class Person: PFObject, PFSubclassing,TemplateValueHolder
 {
    enum Category:Int {
        case Person,Company,Band
    }
    class func parseClassName() -> String {
        return "Person"
    }
    var category: Category = Category.Person
    
    var firstName: String = ""
    var lastName: String = ""

    // we don't store a role table in db, but just the index value
    @NSManaged var roleIdx: Int
    var role: Role {
        get { return Role.getInstanceWithIdx(roleIdx)! }
        set { roleIdx = newValue.typeIdx }
    }
    @NSManaged var secondaryRoleIdx: Int
    var secondaryRole: Role {
        get { return Role.getInstanceWithIdx(secondaryRoleIdx)! }
        set { secondaryRoleIdx = newValue.typeIdx }
    }
    
    @NSManaged var roleDetails: String
    @NSManaged var phoneNumber: String
    @NSManaged var email: String
    @NSManaged var address: String
    @NSManaged var companyName: String
    @NSManaged var age: Int
    @NSManaged var parentName: String  // if minor
    @NSManaged var parentEmail: String
    @NSManaged var parentRelationship: String
    @NSManaged var bandName: String
    @NSManaged var bandNumberMembers: Int
    @NSManaged var studioplusUsername: String // account user name ( optional )
    
    func manualInit() {
        roleDetails = ""
        phoneNumber = ""
        email = ""
        address = ""
        companyName = ""
        age = 0
        parentName = ""
        parentEmail = ""
        parentRelationship = ""
        bandName = ""
        bandNumberMembers = 0
        studioplusUsername = ""
    }
    func getName() -> String {
        return lastName + ", " + firstName
    }
    func setTemplateValues( deal:Deal )  {
        deal.setTemplateValue(TemplateId.PersonFirstName, value: firstName)
        deal.setTemplateValue(TemplateId.PersonLastName, value: lastName)
        deal.setTemplateValue(TemplateId.PersonPhoneNumber, value: phoneNumber)
        deal.setTemplateValue(TemplateId.PersonEmail, value: email)
        deal.setTemplateValue(TemplateId.PersonAddress, value: address)
        deal.setTemplateValue(TemplateId.PersonPrimaryRole, value: role.getLabel())
        deal.setTemplateValue(TemplateId.PersonSecondaryRole, value: secondaryRole.getLabel())
        deal.setTemplateValue(TemplateId.PersonRoleDetails, value: roleDetails)
        deal.setTemplateValue(TemplateId.PersonBandName, value: bandName)
        deal.setTemplateValue(TemplateId.PersonBandNumMembers, value: "\(bandNumberMembers)")
    }
}