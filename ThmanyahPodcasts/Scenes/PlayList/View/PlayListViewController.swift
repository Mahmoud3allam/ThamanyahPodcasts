//
//  PlayListViewController.swift
//  ThmanyahPodcasts
//
//  Created Mahmoud Allam on 24/11/2023.
//  Copyright © 2023 https://github.com/Mahmoud3allam. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import UIKit
class PlayListViewController: UIViewController {
    var presenter: PlayListPresenterProtocol!
    lazy var containerView: PlayListContainerView = {
        var view = PlayListContainerView(presenter: self.presenter)
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
}

extension PlayListViewController: PlayListViewProtocol {
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.containerView.headerView.isHidden = true
        }
    }

    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.containerView.headerView.isHidden = false
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
                self.containerView.layoutIfNeeded()
            }
        }
    }

    func setPlaylistHeaderData(dataSource: PlaylistDataSource) {
        self.containerView.setPlaylistHeaderData(dataSource: dataSource)
    }

    func hidePlaylistHeaderView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.containerView.headerView.isHidden = true
        }
    }

    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.containerView.scrollView.isScrollEnabled = true
            self.containerView.tableView.allowsSelection = true
            self.containerView.reloadTableView()
        }
    }

    func playEpisode(dataSource: PodcastPlayer.Presentable) {
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.podcastPlayer.configure(presentable: dataSource)
            tabBarController.expandPodcastPlayer()
        }
    }

    func selectRow(at indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.containerView.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
}
