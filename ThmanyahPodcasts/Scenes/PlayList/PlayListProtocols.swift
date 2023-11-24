//
//  PlayListProtocols.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 24/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Foundation
protocol PlayListViewProtocol: AnyObject {
    var presenter: PlayListPresenterProtocol! { get set }

    func showLoading()
    func hideLoading()
    func setPlaylistHeaderData(dataSource: PlaylistDataSource)
    func hidePlaylistHeaderView()
    func reloadTableView()
}

protocol PlayListPresenterProtocol {
    var view: PlayListViewProtocol? { get set }

    func login()
    var didFetchedPlayList: Bool { get }
    var playListSectionHeaderDataSource: PlayListSectionHeaderDataSource? { get }
    func numberOfEposides() -> Int
    func configureEposidesCell(cell: EposideCellDataSourceProtocol, indexPath: IndexPath)
}

protocol PlayListRouterProtocol {}

protocol PlayListInteractorInPutProtocol {
    var presenter: PlayListInteractorOutPutProtocol? { get set }

    func login(email: String, password: String)
    func fetchPlayList()
}

protocol PlayListInteractorOutPutProtocol: AnyObject {
    func loggedInSucsessfully()
    func failedToLogin(errorMessage: String)
    func didFetchedPlayListSucsessfully(playListDetails: PlayListDetails)
    func failedToFetchPlayList(errorMessage: String)
}

protocol EposideCellDataSourceProtocol {
    func setData(dataSource: EposideCellDataSource)
}
