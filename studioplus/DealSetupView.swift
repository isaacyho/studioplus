//
//  DealSetup.swift
//  studioplus
//
//  Created by Isaac Ho on 8/31/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
import UIKit

// typically the calling table view cell / subview will know what person is involved in the deal.
//  It's up to the delegate to fill in the rest of the deal details ( project, etc. )
protocol MakeDealListener {
    func onMakeDeal( person: Person )
}

class DealSetupView: UIView {
  
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var categoryControl: UISegmentedControl!
    @IBOutlet weak var detailsScrollView: UIScrollView!
    
    enum Category:Int {
        case All=0, People, Locations, Materials, Music
    }
    var sceneMgr:AddProjectSceneManager!
    var detailsViews: [UIView] = [];
    class func instanceFromNib( sceneMgr_: AddProjectSceneManager ) -> DealSetupView {
        var newItem = UINib(nibName: "DealSetupView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! DealSetupView
        
        newItem.sceneMgr = sceneMgr_
        
        // for now, just do people
        newItem.jumpToCategory(Category.All)
        return newItem
    }
    func setMainPanel( view: UIView ) {
        detailsScrollView.subviews.map({ $0.removeFromSuperview() })
        detailsScrollView.addSubview( view )
        detailsScrollView.setNeedsDisplay()
    }
    func jumpToCategory( category_:Category ) {
        var mainView:UIView!
        projectNameLabel.text = sceneMgr.currentProject.name
        
        switch( category_ ) {
            case .All:
                var scrollMainView = UIScrollView()
                mainView = scrollMainView
                mainView.frame = detailsScrollView.frame

                scrollMainView.contentSize = CGSize(width: 650, height: 650*4 )
               
                var yCoord = 0
                var view:UIView = DealSetupPeopleView.instanceFromNib(sceneMgr)
                
                view.frame = CGRect(x:0,y:yCoord,width:670,height:650)
                mainView.addSubview(view)
                yCoord += 650
                
                view = DealSetupMusicView.instanceFromNib(sceneMgr)
                view.frame = CGRect(x:0,y:yCoord,width:670,height:650)
                mainView.addSubview(view)
                yCoord += 650
                
                
                view = DealSetupLocationView.instanceFromNib(sceneMgr)
                view.frame = CGRect(x:0,y:yCoord,width:670,height:650)
                mainView.addSubview(view)
                yCoord += 650

                view = DealSetupMaterialsView.instanceFromNib(sceneMgr)
                view.frame = CGRect(x:0,y:yCoord,width:670,height:650)
                mainView.addSubview(view)
            
            case .People: mainView = DealSetupPeopleView.instanceFromNib(sceneMgr)
            case .Music: mainView = DealSetupMusicView.instanceFromNib(sceneMgr)
            case .Locations: mainView = DealSetupLocationView.instanceFromNib(sceneMgr)
            case .Materials: mainView = DealSetupMaterialsView.instanceFromNib(sceneMgr)
        }
        setMainPanel(mainView!)
    }
    @IBAction func onCategoryChange(sender: AnyObject) {
        // swap out the detailsScrollView contents
        var category = Category(rawValue: categoryControl.selectedSegmentIndex)!
        jumpToCategory( category )
    }
}