//
//  PlayListContainerView.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 24/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
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
        tableView.allowsSelection = true
        tableView.backgroundColor = Colors.background.color
        tableView.contentInset = UIEdgeInsets(top: -22, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EposidesCell.self, forCellReuseIdentifier: NSStringFromClass(EposidesCell.self))
        tableView.clipsToBounds = true
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 12
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return tableView
    }()

    var tableViewHeightAnchor: NSLayoutConstraint?

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
        self.addSubViews()
        self.setupHeaderView()
        self.setupTableViewContainerViewConstraints()
        self.setupTableViewConstraints()
    }

    private func addSubViews() {}

    private func setupHeaderView() {
        self.vStackView.addArrangedSubview(self.headerView)
        self.headerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        self.headerView.isHidden = true
    }

    private func setupTableViewContainerViewConstraints() {
        self.vStackView.addArrangedSubview(self.tableViewContainerView)
        self.tableViewHeightAnchor = self.tableViewContainerView.heightAnchor.constraint(equalToConstant: (10 * 106) + 32)
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
        self.tableViewHeightAnchor?.constant = self.tableView.contentSize.height - 80
    }

    func setPlaylistHeaderData(dataSource: PlaylistDataSource) {
        self.headerView.setPlaylistHeaderData(dataSource: dataSource)
    }
}
