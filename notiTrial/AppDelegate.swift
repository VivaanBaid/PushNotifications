//
//  AppDelegate.swift
//  notiTrial
//
//  Created by Vivaan Baid on 22/10/21.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let replyAction = UNNotificationAction(
                identifier: "reply.action",
                title: "Reply to this message",
                options: [])
        
        let pushNotificationButtons = UNNotificationCategory(
             identifier: "allreply.action",
             actions: [replyAction],
             intentIdentifiers: [],
             options: [])
        
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().setNotificationCategories([pushNotificationButtons])
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { success, error in
            if let e = error{
                print(e.localizedDescription)
            }else{
                print("Success in APNS registry")
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
                
            }
        }
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { mytoken, error in
            if let e = error{
                print(e.localizedDescription)
            }else{
                print(mytoken!)
                
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

