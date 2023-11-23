//
//  MainTabBarController.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 23/11/2023.
//

import Foundation
import UIKit
class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .purple
        self.tabBar.isTranslucent = false
        self.viewControllers = [
            self.setNavigationController(rootViewController: PodcastsRouter.createAnModule(), withTitle: "", withImage: #imageLiteral(resourceName: "Play")),
            self.setNavigationController(rootViewController: ViewController(), withTitle: "Discover", withImage: #imageLiteral(resourceName: "Play"))
        ]
    }

    fileprivate func setNavigationController(rootViewController: UIViewController, withTitle: String, withImage: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = withTitle
        navController.tabBarItem.title = withTitle
        navController.tabBarItem.image = withImage
        return navController
    }
}
