//
//  DealQuestionsCollaboratorView.swift
//  studioplus
//
//  Created by Isaac Ho on 9/16/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class DealQuestionsCollaboratorView: UIView, TemplateValueHolder, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var sceneMgr: AddProjectSceneManager!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var objects = NSBundle.mainBundle().loadNibNamed("DealQuestionsCollaboratorTableViewCell", owner: self, options: nil)
        var cell = objects[0] as! DealQuestionsCollaboratorTableViewCell
        
        cell.clipsToBounds = true
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func setTemplateValues(deal: Deal) {
        
    }
}
