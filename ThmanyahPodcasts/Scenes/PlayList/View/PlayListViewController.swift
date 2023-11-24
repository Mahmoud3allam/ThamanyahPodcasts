//
//  PlayListViewController.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 24/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import UIKit
class PlayListViewController: UIViewController, PlayListViewProtocol {
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

    func showLoading() {
        self.containerView.headerView.isHidden = true
    }

    func hideLoading() {
        self.containerView.headerView.isHidden = false
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            self.containerView.layoutIfNeeded()
        }
    }

    func setPlaylistHeaderData(dataSource: PlaylistDataSource) {
        self.containerView.setPlaylistHeaderData(dataSource: dataSource)
    }

    func hidePlaylistHeaderView() {
        self.containerView.headerView.isHidden = true
    }

    func reloadTableView() {
        DispatchQueue.main.async {
            self.containerView.reloadTableView()
        }
    }
}
