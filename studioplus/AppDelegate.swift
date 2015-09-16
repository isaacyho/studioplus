//
//  AppDelegate.swift
//  studioplus
//
//  Created by Isaac Ho on 8/30/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func buildDummyDealObjects() {
        var hash:[String:String] = ["esp1":"single project",
            "300":"James",
            "304":"Cameron",
            "12":"Penelope Cruz",
            "6":"September 8, 2015"
        ]
        
        var d = DummyDeal(className: "DummyDeal")
        d.snapshotValues = hash
        d.save()
    }
    var appId = "avp5gMuDJUoJ58OXhQbUAaNqs6Yt1lQek5Uu0ko8"
    var clientKey = "HEXaeynpedVu0ZAz9j5S0gc8sNqNyatsPEbxSE6k"
        
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        Role.registerSubclass()
        Person.registerSubclass()
        Location.registerSubclass()
        Material.registerSubclass()
        Track.registerSubclass()
        Project.registerSubclass()
        Deal.registerSubclass()
        DummyDeal.registerSubclass()
        Parse.setApplicationId(appId, clientKey: clientKey)

        /* HACK
        DummyDeal.registerSubclass()
        Parse.setApplicationId(appId, clientKey: clientKey)
        var vc = storyboard.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
        //self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        

      
        if ( true ) { return true }
        // END HACK*/
        
       // var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //var initialViewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
       //self.window?.rootViewController = initialViewController
       // self.window?.makeKeyAndVisible()

        // init model class vars
        Role.classCustomInit()
        Fabric.with([Crashlytics()])
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

