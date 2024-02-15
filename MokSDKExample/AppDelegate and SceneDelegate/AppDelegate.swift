//
//  AppDelegate.swift
//  MokSDKExample
//
//  Created by Bindu R S on 23/11/23.
//

import UIKit
import Unomok
import FirebaseMessaging
import FirebaseCore
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let id = "MOASDK_1001"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let _ = MokSDK(
            isProductionEnv: false,
            sdkReadKey: "YOUR_MOK_SDK_READ_KEY",
            sdkWriteKey: "YOUR_MOK_SDK_WRITE_KEY")
        MokSDK.updateUser(
            userID: id,
            withParameters: [
                "name": id+"_iOS_SDK"
            ]) { sucessMessage, error in
                
            }
        UNUserNotificationCenter.current().delegate = self
        
        MokSDK.registerForRemoteNotification(type: .fcm)
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        apnsToken = deviceToken
        MokSDK.registerDeviceTokenForRemoteNotification(deviceToken: deviceToken) { token, message, errorMessage  in
            print("=========== Register For Remote Notification With Device Token ============")
            if let token {
                print("FCM token : \(token)")
            }
            
            if let message {
                print(message)
            }
            if let errorMessage {
                print(errorMessage)
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
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        Messaging.messaging().appDidReceiveMessage(userInfo)
        MokSDK.handlePushNotification(userInfo: userInfo)
        completionHandler(.newData)
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        Messaging.messaging().appDidReceiveMessage(userInfo)
        MokSDK.handlePushNotification(userInfo: userInfo)
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let userInfo = response.notification.request.content.userInfo as? [String: Any] {
            print(userInfo)
            Messaging.messaging().appDidReceiveMessage(userInfo)
        }
        completionHandler()
    }
}


