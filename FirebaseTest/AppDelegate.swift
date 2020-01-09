//
//  AppDelegate.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/09.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

}

