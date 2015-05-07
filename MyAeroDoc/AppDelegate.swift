//
//  AppDelegate.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 21.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //set colors !
        UINavigationBar.appearance().barTintColor = UIColor(red: 100.0/255.0, green: 140.0/255.0, blue:
            163.0/255.0, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        if(application.respondsToSelector("registerUserNotificationSettings:")){// registerUserNotificationSettings: maybe
            var category = self.registerActions()
            var categories = NSMutableSet()
            categories.addObject(category)
            var notificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound, categories:categories as Set<NSObject>)// may be problem
            UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
            UIApplication.sharedApplication().registerForRemoteNotifications()
            
        }
        else{
            let types:UIRemoteNotificationType = (.Alert | .Badge | .Sound)
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(types)
            
        }
        return true
    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        println(deviceToken)
        AeroDocAPIClient.sharedInstance().deviceToken = deviceToken
        println(AeroDocAPIClient.sharedInstance().deviceToken)
    }
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println("failure((\(error)")
    }
    func registerActions() ->(UIMutableUserNotificationCategory) {
        var acceptLeadAction = UIMutableUserNotificationAction()
        acceptLeadAction.identifier = "Accept"
        acceptLeadAction.title = "Accept"
        acceptLeadAction.activationMode = UIUserNotificationActivationMode.Foreground
        acceptLeadAction.destructive = false
        acceptLeadAction.authenticationRequired = false
        
        var category = UIMutableUserNotificationCategory()
        category.identifier = "acceptLead"
        category.setActions([acceptLeadAction], forContext: UIUserNotificationActionContext.Default)
        return category
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        var recId: String? = userInfo["id"] as? String;
        var name: String? = userInfo["name"] as? String;
        var phone: String? = userInfo["phone"] as? String;
        var location: String? = userInfo["location"] as? String;
        var messageType: String = userInfo["messageType"] as! String;
        if ((messageType.isEqual("accepted_lead")) != false){
            var nortification = NSNotification(name: "LeadAcceptedNotification", object: userInfo)
            NSNotificationCenter.defaultCenter().postNotification(nortification)
            
        }
        else{
            var alert = UIAlertView(title: "", message: "Lead \(name) is available", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
            var nortification = NSNotification(name: "LeadAddedNotification", object: userInfo)
            NSNotificationCenter.defaultCenter().postNotification(nortification)
            
        }

    }
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
    if(identifier == "accept"){
    var nortification = NSNotification(name: "AcceptNotification", object: userInfo)
    NSNotificationCenter.defaultCenter().postNotification(nortification)
    }
    completionHandler()
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

