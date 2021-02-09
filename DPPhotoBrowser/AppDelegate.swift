//
//  AppDelegate.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/4.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let vc = ViewController()
        window?.rootViewController = vc
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        return true
    }

}

