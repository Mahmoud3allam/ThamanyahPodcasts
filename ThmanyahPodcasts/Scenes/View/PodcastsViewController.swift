//
//  PodcastsViewController.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 23/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import UIKit
class PodcastsViewController: UIViewController, PodcastsViewProtocol {
    var presenter: PodcastsPresenterProtocol!
    lazy var containerView: PodcastsContainerView = {
        var view = PodcastsContainerView(presenter: self.presenter)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.presenter.login()
    }

    override func loadView() {
        super.loadView()
        self.view = containerView
    }

    func enableShimmerEffect() {
        print("Enable Shimmer")
    }

    func disableShimmerEffect() {
        print("Disable Shimmer")
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        LocalizationManager.shared.toggleLanguage(initialViewController: MainTabBarController())
    }
}
