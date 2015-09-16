//
//  Material.swift
//  studioplus
//
//  Created by Isaac Ho on 9/1/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
class Material: PFObject, PFSubclassing, TemplateValueHolder {
    
    // "Type" is reserved keyword
    enum MaterialType: Int {
        case Wardrobe, Props, ArtImage,Equipment
    }
    let materialTypeLabels = ["Wardrobe", "Props", "Art/Image", "Equipment"]
    
    class func parseClassName() -> String {
        return "Material"
    }
    @NSManaged var name:String
    @NSManaged var owner:Person?
    @NSManaged var rentalStartDate: NSDate
    @NSManaged var rentalEndDate: NSDate
    @NSManaged var typeRawValue: Int
    var type: MaterialType! {
        get { return MaterialType(rawValue: typeRawValue)!  }
        set { typeRawValue = newValue.rawValue }
    }
    
    @NSManaged var descriptionText: String
    @NSManaged var fee: String
    @NSManaged var feeType: String
    var bRentedNotPurchased: Bool! {
        get { return self["bRentedNotPurchased"] as! Bool }
        set { self["bRentedNotPurchased"] = newValue }
    }

    var bExclusive: Bool! {
        get { return self["bExclusive"] as! Bool }
        set { self["bExclusive"] = newValue }
    }

    
    func manualInit() {
      name = ""
      rentalStartDate = NSDate()
      rentalEndDate = NSDate()
      type = .Wardrobe
      descriptionText = ""
       fee = ""
        feeType = ""
        
        bRentedNotPurchased = false
        bExclusive = false
    }
    
    func getTypeLabel() -> String {
        return materialTypeLabels[ type.rawValue ]
    }
    func setTemplateValues(deal: Deal) {
        deal.setTemplateValue(TemplateId.MaterialType, value: materialTypeLabels[type.rawValue])
        deal.setTemplateValue(TemplateId.MaterialDescription, value: descriptionText)
        deal.setTemplateValue(TemplateId.MaterialFee, value: fee)
        deal.setTemplateValue(TemplateId.MaterialFeeType, value: feeType)

        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        deal.setTemplateValue(TemplateId.MaterialRentalStartDate, value: formatter.stringFromDate(rentalStartDate) )

        deal.setTemplateValue(TemplateId.MaterialRentalEndDate, value: formatter.stringFromDate(rentalEndDate) )
        deal.setTemplateValue(TemplateId.MaterialExclusiveNonExclusive, value: (bExclusive == true ? "exclusive" : "nonexclusive"))
    }
}