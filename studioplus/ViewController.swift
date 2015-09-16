//
//  ViewController.swift
//  studioplus
//
//  Created by Isaac Ho on 8/30/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var sidebar: UIView!
    @IBOutlet weak var mainPanel: UIView!

    @IBOutlet weak var studioNameLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var sceneMgr: AddProjectSceneManager!
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        self.resignFirstResponder()
        lastTextFieldChosen?.resignFirstResponder()
        animateFrameToZero()
        self.view.endEditing(true)
    }
    func animateFrameToZero() {
        UIView.beginAnimations( "animateView", context: nil)
        var movementDuration:NSTimeInterval = 0.35
        var frame : CGRect = self.view.frame
        frame.origin.y = 0
        self.view.frame = frame
        UIView.commitAnimations()
        lastTextFieldChosen?.resignFirstResponder()
    }
    var lastTextFieldChosen: UITextField?

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("should return" )
        return true
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        println("should end editing")
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        println("did end editing")
    }
    func textFieldDidBeginEditing(textField: UITextField) { // became first responder
        
        //move textfields up
        let myScreenRect: CGRect = UIScreen.mainScreen().bounds
        let keyboardHeight : CGFloat = 352
        var textFieldTrueOrigin = textField.superview!.convertPoint(textField.frame.origin, toView:UIApplication.sharedApplication().keyWindow!.rootViewController!.view)
        println("textFieldTrueOrigin: \(textFieldTrueOrigin.y)")
        
        
        
        
        
        UIView.beginAnimations( "animateView", context: nil)
        var movementDuration:NSTimeInterval = 0.35
        var needToMove: CGFloat = 0
        var frame : CGRect = self.view.frame
        
        if (textFieldTrueOrigin.y + textField.frame.size.height + UIApplication.sharedApplication().statusBarFrame.size.height > (myScreenRect.size.height - keyboardHeight)) {
            var a = (textFieldTrueOrigin.y + textField.frame.size.height + UIApplication.sharedApplication().statusBarFrame.size.height)
            needToMove = a - (myScreenRect.size.height - keyboardHeight)
        }
        
        // XXX
        needToMove = 0
        frame.origin.y = -needToMove
        self.view.frame = frame
        UIView.commitAnimations()
    }
   
    // actually sets the subview of the sidebar view
    func loadViewFromNib( nibName: String ) -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "SimpleCustomView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    
        return view
    }
    func setSidebarView( view: UIView ) {
        sidebar.subviews.map({ $0.removeFromSuperview() })
        sidebar.addSubview( view )
        sidebar.setNeedsDisplay()
    }
    func setMainPanelView( view: UIView ) {
        mainPanel.subviews.map({ $0.removeFromSuperview() })
        mainPanel.addSubview( view )
        mainPanel.setNeedsDisplay()
    }

    @IBAction func onBackButton(sender: AnyObject) {
        sceneMgr.goBack()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     /*   [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(keyboardWillShow:)
        name:UIKeyboardWillShowNotification
        object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(keyboardWillHide:)
        name:UIKeyboardWillHideNotification
        object:nil];*/
        
        studioNameLabel.text = PFUser.currentUser()?.objectForKey("studioName") as! String
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "animateFrameToZero", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

