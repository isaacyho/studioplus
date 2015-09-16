//
//  DealSetupPeopleTableCell.swift
//  studioplus
//
//  Created by Isaac Ho on 8/31/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

class DealSetupPeopleTableCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var isMinorLabel: UILabel!
    
    var delegate: MakeDealListener!
    
    @IBAction func onMakeDeal(sender: AnyObject) {
        println( "make deal" )
        delegate.onMakeDeal(person!)
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    var collaborators: [Person]? {
        didSet {
            if ( collaborators!.count > 0 ) {
                companyNameLabel.text = ""
                isMinorLabel.text = ""
                roleLabel.text = ""
  
                var text = ""
                for c in collaborators! {
                    text += c.getName()+";"
                }
                text.substringToIndex(text.endIndex.predecessor())
                nameLabel.text = text
            }
        }
    }
    var person: Person? {
        didSet {
            companyNameLabel.text = person?.companyName
            nameLabel.text = person?.getName()
            isMinorLabel.text = ( person?.age < 21 ? "Minor" : "Adult" )
            roleLabel.text = ( person?.role.name )
        }
    }
}