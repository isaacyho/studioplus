//
//  SignupViewController.swift
//  studioplus
//
//  Created by Isaac Ho on 9/14/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var projectOwnerEmailTextField: UITextField!
    @IBOutlet weak var projectOwnerTextField: UITextField!
    @IBOutlet weak var studioNameTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var over13SegControl: UISegmentedControl!
    
   
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func onSignup(sender: AnyObject) {
        let user = PFUser()
        
        if ( count(userTextField.text) == 0 ||
            count(passwordTextField.text) == 0 ||
            count(projectOwnerEmailTextField.text) == 0 ||
            count(projectOwnerTextField.text) == 0 ||
            count(repeatPasswordTextField.text) == 0 ) {
                self.showErrorView( NSError(domain: "All fields must be completed", code: -1, userInfo: nil ) )
                return
        }
        
        user.username = userTextField.text
        user.password = passwordTextField.text
        user.email = projectOwnerEmailTextField.text
        user.setValue(studioNameTextField.text, forKey: "studioName")
        user.setValue(projectOwnerTextField.text, forKey:"projectOwner")

        if ( user.password != repeatPasswordTextField.text ) {
            self.showErrorView( NSError(domain: "Password and Repeat Password must match", code: -1, userInfo: nil ) )
            return
        }
        if ( over13SegControl.selectedSegmentIndex != 1 ) {
            self.showErrorView( NSError(domain: "You must be over 13 years of age", code:-1, userInfo:nil ))
            return
        }

        user.signUpInBackgroundWithBlock { succeeded, error in
            if (succeeded) {
                //The registration was successful, go to the wall
                self.performSegueWithIdentifier("toLogin", sender: nil)
            } else if let error = error {
                //Something bad has occurred
                self.showErrorView(error)
            }
        }        
    }
}
