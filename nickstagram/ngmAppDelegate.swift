//
//  AppDelegate.swift
//  nickstagram
//
//  Created by Nick McDonald on 2/21/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD


@UIApplicationMain
class ngmAppDelegate: UIResponder, UIApplicationDelegate {
    
    private static let applicationID: String = "Nickstagram"
    private static let clientKey: String = "29397f3759120ec0b1e329a61fdc027a"
    private static let server: String = "https://aqueous-mountain-26341.herokuapp.com/parse"
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SVProgressHUD.setDefaultStyle(.dark)
        
        Parse.initialize(with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) in
            configuration.applicationId = ngmAppDelegate.applicationID
            configuration.clientKey = ngmAppDelegate.clientKey
            configuration.server = ngmAppDelegate.server
        }))
        
        if ngmUser.currentUser != nil {
            // Go to tweets screen since there is a logged in user.
            print("There is a current User!")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeTabBarController")
            window?.rootViewController = vc
        }
        
        NotificationCenter.default.addObserver(forName: UserNotificationCenterOps.userDidLogout.notification, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            self.window?.rootViewController = vc
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

