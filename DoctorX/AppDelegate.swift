//
//  AppDelegate.swift
//  DoctorX
//
//  Created by Marwa on 5/28/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ref: DatabaseReference?

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool  {
        // Override point for customization after application launch.
        FirebaseApp.configure()
//     ref = Database.database().reference()
//    let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    if Auth.auth().currentUser == nil{
//   
//        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "MainView") as UIViewController
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = initialViewControlleripad
//        self.window?.makeKeyAndVisible()
//    }else if (Auth.auth().currentUser != nil){
//        let userId = Auth.auth().currentUser?.uid
//        self.ref?.child("Users").queryOrdered(byChild: "id").queryEqual(toValue: userId).observeSingleEvent(of: .value, with: { (snapshot) in
//            let data = snapshot.value as? [String:Any]
//            print(data!)
//            if data == nil {
//                print("empty data")
//                return
//            }else{
//                print("not empty data")
//            for (key,value) in data! {
//                let user = value as! [String:String]
//                for (key,value) in user {
//                    if key == "privilege" {
//                        if value == "1"{
//                            
//                            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "MainView") as UIViewController
//                            self.window = UIWindow(frame: UIScreen.main.bounds)
//                            self.window?.rootViewController = initialViewControlleripad
//                            self.window?.makeKeyAndVisible()
//                            
//                        }else if value == "2"{
//                            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "MainView") as UIViewController
//                            self.window = UIWindow(frame: UIScreen.main.bounds)
//                            self.window?.rootViewController = initialViewControlleripad
//                            self.window?.makeKeyAndVisible()
//                            
//                        }
//
//                    }
//                }
//            }
//            }
//
//        })
//    }
    
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

