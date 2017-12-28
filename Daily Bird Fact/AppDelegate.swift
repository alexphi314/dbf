//
//  AppDelegate.swift
//  Daily Bird Fact
//
//  Created by Alex Philpott on 5/16/16.
//  Copyright © 2016 Philpott Studios. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
            
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
        
        let app: UIApplication = UIApplication.shared
        app.cancelAllLocalNotifications()
        app.applicationIconBadgeNumber = 0
        
        //setting next notification time
        let x: Double = 24*3600
        //let notifdate = dateToFire(x,min: y,sec: z)
        let notification = UILocalNotification()
        notification.fireDate = Date(timeIntervalSinceNow: x*1)
        notification.alertBody = "Check out today's bird fact!"
        notification.alertAction = "Learn something new!"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
        notification.applicationIconBadgeNumber = 1
        UIApplication.shared.scheduleLocalNotification(notification)
        
        let notification2 = UILocalNotification()
        notification2.fireDate = Date(timeIntervalSinceNow: x*2)
        notification2.alertBody = "Check out today's bird fact!"
        notification2.alertAction = "Learn something new!"
        notification2.soundName = UILocalNotificationDefaultSoundName
        notification2.userInfo = ["CustomField1": "w00t"]
        notification2.applicationIconBadgeNumber = 2
        UIApplication.shared.scheduleLocalNotification(notification2)
        
        let notification3 = UILocalNotification()
        notification3.fireDate = Date(timeIntervalSinceNow: x*3)
        notification3.alertBody = "Come back, the birds miss you!"
        notification3.alertAction = "Learn something new!"
        notification3.soundName = UILocalNotificationDefaultSoundName
        notification3.userInfo = ["CustomField1": "w00t"]
        notification3.applicationIconBadgeNumber = 3
        UIApplication.shared.scheduleLocalNotification(notification3)
        
        let notification4 = UILocalNotification()
        notification4.fireDate = Date(timeIntervalSinceNow: x*4)
        notification4.alertBody = "Have you seen today's bird fact?"
        notification4.alertAction = "Learn something new!"
        notification4.soundName = UILocalNotificationDefaultSoundName
        notification4.userInfo = ["CustomField1": "w00t"]
        notification4.applicationIconBadgeNumber = 4
        UIApplication.shared.scheduleLocalNotification(notification4)
        
        let notification5 = UILocalNotification()
        notification5.fireDate = Date(timeIntervalSinceNow: x*5)
        notification5.alertBody = "Check out today's bird fact!"
        notification5.alertAction = "Learn something new!"
        notification5.soundName = UILocalNotificationDefaultSoundName
        notification5.userInfo = ["CustomField1": "w00t"]
        notification5.applicationIconBadgeNumber = 5
        UIApplication.shared.scheduleLocalNotification(notification5)
        
        let notification6 = UILocalNotification()
        notification6.fireDate = Date(timeIntervalSinceNow: x*6)
        notification6.alertBody = "Did you hear that? That's the birds calling you back!"
        notification6.alertAction = "Learn something new!"
        notification6.soundName = UILocalNotificationDefaultSoundName
        notification6.userInfo = ["CustomField1": "w00t"]
        notification6.applicationIconBadgeNumber = 6
        UIApplication.shared.scheduleLocalNotification(notification6)
        
        let notification7 = UILocalNotification()
        notification7.fireDate = Date(timeIntervalSinceNow: x*7)
        notification7.alertBody = "Today's bird fact is super cool, you should check it out!"
        notification7.alertAction = "Learn something new!"
        notification7.soundName = UILocalNotificationDefaultSoundName
        notification7.userInfo = ["CustomField1": "w00t"]
        notification7.applicationIconBadgeNumber = 7
        UIApplication.shared.scheduleLocalNotification(notification7)
        
        /*print("setting default keys")
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultValue = ["MyKey" : 1 as Int]
        defaults.registerDefaults(defaultValue)*/
        
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("DEVICE TOKEN = \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

