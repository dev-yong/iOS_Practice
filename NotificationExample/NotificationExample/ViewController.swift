//
//  ViewController.swift
//  NotificationExample
//
//  Created by 이광용 on 2018. 1. 31..
//  Copyright © 2018년 이광용. All rights reserved.
//

// https://github.com/kenechilearnscode/UserNotificationsTutorial/tree/master/iOS10RichNotificationsTutorial

import UIKit
import UserNotifications

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
    }

    @IBAction func notificationAction(_ sender: UIButton) {
        print("tapped")
        
        let content = UNMutableNotificationContent()
        content.title = "Alert"
        content.subtitle = "Your dog is escaping"
        content.body = "Please check app"
        content.categoryIdentifier = "category"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
        }
    }
    
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "actionOK":
            print("Action alert_ok")
        case "actionCancel":
            print("Action alert_ok")
        default:
            break
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
