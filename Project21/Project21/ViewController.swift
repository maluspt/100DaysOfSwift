//
//  ViewController.swift
//  Project21
//
//  Created by Maria Luiza Carvalho Sperotto on 13/11/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//


import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(initialSchedule))
        
        
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("yay")
            } else {
                print ("nay")
            }
        }
        
        
    }
    
    @objc func initialSchedule() {
        scheduleLocal(delaySeconds: 5)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
         // pull out the buried userInfo dictionary
        
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                //challenge 1
                let alert = UIAlertController(title: "Swipe", message: "The user swiped to unlock", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                //user swiped to unlock
                print("Default identifier")
            case "show":
                //user tapped our "show more info" button
                let alert = UIAlertController(title: "Button", message: "The user tapped the \"Tell me more\" button", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                print("Show more information")
            case "delay":
                scheduleLocal(delaySeconds: 3600*24)
            default:
                break
            }
        }
        
        completionHandler()
    }
    
    @objc func scheduleLocal() {
        
        registerCategories()
        
    }
    
    func scheduleLocal(delaySeconds: TimeInterval) {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        
        //what will be shown
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //request the alert
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me More", options: .foreground)
        let delay = UNNotificationAction(identifier: "delay", title: "Remind me Later", options: .authenticationRequired)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, delay], intentIdentifiers: [])
        
        
        center.setNotificationCategories([category])
    }


}

