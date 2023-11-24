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
        print(LocalizationManager.shared.isAppInArabicLanguage())
        print(LocalizationManager.shared.isAppInEnglishLanguage())
        self.tabBar.isTranslucent = false
        self.viewControllers = [
            self.setNavigationController(rootViewController: PodcastsRouter.createAnModule(),
                                         withTitle: MainTabBarTabs.home.getDisplayableTitle(),
                                         withImage: Images.home.image),
            self.setNavigationController(rootViewController: UIViewController(),
                                         withTitle: MainTabBarTabs.search.getDisplayableTitle(),
                                         withImage: Images.search.image),
            self.setNavigationController(rootViewController: UIViewController(),
                                         withTitle: MainTabBarTabs.Library.getDisplayableTitle(),
                                         withImage: Images.library.image)
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

enum MainTabBarTabs {
    case home
    case search
    case Library

    func getDisplayableTitle() -> String {
        let isAppInArabicMode = LocalizationManager.shared.isAppInArabicLanguage()
        switch self {
        case .home:
            return isAppInArabicMode ? "الرئيسية" : "Home"
        case .search:
            return isAppInArabicMode ? "البحث" : "Search"
        case .Library:
            return isAppInArabicMode ? "المكتبة" : "Library"
        }
    }
}
