//
//  MainTabBarController.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 23/11/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    var hasHomeButton: Bool {
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        guard let safeAreaBottom = window?.safeAreaInsets.bottom else {
            return false
        }
        return safeAreaBottom <= 0
    }

    private let tabBarShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.background.color
        view.clipsToBounds = true
        view.applyDropShadow()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureTabBarAppearance()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasHomeButton { setTabBarHeight(height: 90) }
        tabBarShadowView.frame = tabBar.frame
        if !hasHomeButton { setTabBarWidth(withMargin: 30) }
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
        if !hasHomeButton {
            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
        }
        hideTabBarBorder()
        addCustomTabBarView()
        setupTabBarFont()
        tabBar.barTintColor = .white
        tabBar.tintColor = Colors.haileyBlue.color
        tabBar.isTranslucent = false
    }

    private func createNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = MainNavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }

    private func hideTabBarBorder() {
        tabBar.backgroundImage = UIImage.from(color: .clear)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }

    private func setTabBarWidth(withMargin margin: CGFloat) {
        tabBar.frame.size.width = view.frame.width - (margin * 2)
        tabBar.frame.origin.x = (margin * 2) / 2
    }

    private func setTabBarHeight(height: CGFloat) {
        var newFrame = tabBar.frame
        newFrame.size.height = height
        newFrame.origin.y -= (height - tabBar.frame.size.height)
        tabBar.frame = newFrame
    }

    private func addCustomTabBarView() {
        tabBarShadowView.frame = tabBar.frame
        view.addSubview(tabBarShadowView)
        view.bringSubviewToFront(tabBar)
    }

    private func setupTabBarFont() {
        let tabBarItemTitleTypography = Typography(size: .tabBar, weight: .medium)
        let attributes = [NSAttributedString.Key.font: tabBarItemTitleTypography.font]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
}
