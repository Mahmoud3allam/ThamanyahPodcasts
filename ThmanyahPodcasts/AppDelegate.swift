//
//  AppDelegate.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 23/11/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        LocalizationManager.shared.setAppLanguage(lang: .arabic)
        window.rootViewController = MainTabBarController()
        window.makeKeyAndVisible()
        return true
    }
}
