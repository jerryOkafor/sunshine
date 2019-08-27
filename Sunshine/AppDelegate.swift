//
//  AppDelegate.swift
//  Sunshine
//
//  Created by Jerry Hanks on 18/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit
import CoreData
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let dataController = DataController(modelName: "Sunshine")
    
    var reachability:Reachability?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        reachability = Reachability()
        try? reachability?.startNotifier()
        
        //laod data controller
        self.dataController.load {
            print("Data controller loaded!")
        }
        
        
        //inject data controller to the first viewcontroller
        let navigationController = window?.rootViewController as! UINavigationController
        let homeVC = navigationController.topViewController as! HomeViewController
        homeVC.dataController = dataController
        
        return true
    }

    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveViewContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveViewContext()
    }
    
    func saveViewContext() {
        try? dataController.viewContext.save()
    }
}

