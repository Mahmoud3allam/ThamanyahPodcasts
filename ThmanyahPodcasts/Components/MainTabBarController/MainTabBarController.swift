//
//  MainTabBarController.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 23/11/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    var expandedPlayerTopAnchor: NSLayoutConstraint?
    var collapsedPlayerTopAnchor: NSLayoutConstraint?

    lazy var podcastPlayer: PodcastPlayer = {
        var player = PodcastPlayer()
        player.translatesAutoresizingMaskIntoConstraints = false
        player.style = PodcastPlayerStyle.PredefinedStyles.standard.value
        return player
    }()

    private let tabBarShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.background.color
        view.clipsToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureTabBarAppearance()
        self.settingUpPlayerDetailsView()
    }

    private func configureViewControllers() {
        viewControllers = [
            createNavigationController(rootViewController: PlayListRouter.createAnModule(),
                                       title: "Home".localize,
                                       image: Images.home.image),
            createNavigationController(rootViewController: UIViewController(),
                                       title: "Search".localize,
                                       image: Images.search.image),
            createNavigationController(rootViewController: UIViewController(),
                                       title: "Library".localize,
                                       image: Images.library.image)
        ]
    }

    private func configureTabBarAppearance() {
        setupTabBarFont()
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = Colors.haileyBlue.color
        tabBar.isTranslucent = false
        tabBar.applyDropShadow()
    }

    private func createNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = MainNavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }

    private func setupTabBarFont() {
        let tabBarItemTitleTypography = Typography(size: .tabBar, weight: .medium)
        let attributes = [NSAttributedString.Key.font: tabBarItemTitleTypography.font]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
}
