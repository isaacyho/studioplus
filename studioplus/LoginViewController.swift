//
//  LoginViewController.swift
//  studioplus
//
//  Created by Isaac Ho on 9/14/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func unwindFromTabViewController(segue: UIStoryboardSegue) {
        println("back to login vc")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSignup(sender: AnyObject) {
        self.performSegueWithIdentifier("toSignup", sender: self)

    }
    // MARK: - Actions
    @IBAction func logInPressed(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userTextField.text, password: passwordTextField.text) { user, error in
            if user != nil {
                 var storyboard = UIStoryboard(name: "Main", bundle: nil)
                 var initialViewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
                self.presentViewController(initialViewController, animated: true, completion: nil)
                
                // manually create AppProjectSceneManager
                var sceneMgr = AddProjectSceneManager(mainVC_:initialViewController)
                sceneMgr.begin()
                
            } else if let error = error {
                self.showErrorView(error)
            }
        }
    }
}
