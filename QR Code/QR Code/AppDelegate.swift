//
//  AppDelegate.swift
//  QR Code
//
//  Created by Silviya Velani on 18/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//        
//        if UserDefaults.standard.bool(forKey: Constant.isLoginKey)
//        {
//            if let role = UserDefaults.standard.object(forKey: Constant.loginRole) as? String
//            {
//                if role == "user"
//                {
//                    loginViewUser()
//                }
//                else if role == "admin"
//                {
//                   loginViewAdmin()
//                }
//                else
//                {
//                    logoutScreen()
//                }
//            }
//            else
//            {
//                logoutScreen()
//            }
//        }
//        else
//        {
//            logoutScreen()
//        }
        
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

    
    func loginViewUser()
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "User_HomePageViewController")
        
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        window?.rootViewController = nav
    }
    
    func loginViewAdmin()
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Admin_HomePageViewController")
        
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        window?.rootViewController = nav
    }
    
    func logoutScreen()
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "rootNavigationController")
        
        window?.rootViewController = vc
    }
    
    

}

