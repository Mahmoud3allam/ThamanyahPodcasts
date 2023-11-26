//
//  PlayListContainerView.swift
//  ThmanyahPodcasts
//
//  Created Mahmoud Allam on 24/11/2023.
//  Copyright © 2023 https://github.com/Mahmoud3allam. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import UIKit
class PlayListContainerView: StackedScrollableContainerView {
    var presenter: PlayListPresenterProtocol
    lazy var headerView: StretchyHeaderView = {
        var view = StretchyHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    lazy var tableViewContainerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.backgroundColor = Colors.background.color
        tableView.contentInset = UIEdgeInsets(top: -22, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EpisodesCell.self, forCellReuseIdentifier: NSStringFromClass(EpisodesCell.self))
        tableView.clipsToBounds = true
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 12
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return tableView
    }()

    var tableViewHeightAnchor: NSLayoutConstraint?
    var headerHeight: CGFloat = 400

    init(presenter: PlayListPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        self.backgroundColor = Colors.lightGlobal.color
        self.scrollView.delegate = self
        self.layoutUserInterFace()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutUserInterFace() {
        self.scrollView.isScrollEnabled = false
        self.addSubViews()
        self.setupHeaderView()
        self.setupTableViewContainerViewConstraints()
        self.setupTableViewConstraints()
    }

    private func addSubViews() {}

    private func setupHeaderView() {
        self.vStackView.addArrangedSubview(self.headerView)
        self.headerView.heightAnchor.constraint(equalToConstant: self.headerHeight).isActive = true
        self.headerView.isHidden = true
    }

    private func setupTableViewContainerViewConstraints() {
        self.vStackView.addArrangedSubview(self.tableViewContainerView)
        let paddingSpace = 32
        let rowHeight = 106
        self.tableViewHeightAnchor = self.tableViewContainerView.heightAnchor.constraint(equalToConstant: CGFloat((self.presenter.numberOfEpisodes() * rowHeight) + paddingSpace))
        self.tableViewHeightAnchor?.isActive = true
    }

    private func setupTableViewConstraints() {
        self.tableViewContainerView.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.tableViewContainerView.topAnchor, constant: -20),
            self.tableView.leadingAnchor.constraint(equalTo: self.tableViewContainerView.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.tableViewContainerView.trailingAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.tableViewContainerView.bottomAnchor, constant: 0)

        ])
    }

    func reloadTableView() {
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.updateTableViewHeight()
    }

    func updateTableViewHeight() {
        self.tableViewHeightAnchor?.constant = self.tableView.contentSize.height
    }

    func setPlaylistHeaderData(dataSource: PlaylistDataSource) {
        self.headerView.setPlaylistHeaderData(dataSource: dataSource)
    }
}
