//
//  PlayListProtocols.swift
//  ThmanyahPodcasts
//
//  Created Mahmoud Allam on 24/11/2023.
//  Copyright © 2023 https://github.com/Mahmoud3allam. All rights reserved.
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
    func playEpisode(dataSource: PodcastPlayer.Presentable)
    func selectRow(at indexPath: IndexPath)
}

protocol PlayListPresenterProtocol {
    var view: PlayListViewProtocol? { get set }
    var didFetchedPlayList: Bool { get }
    var playListSectionHeaderDataSource: PlayListSectionHeaderDataSource? { get }

    func login()
    func numberOfEpisodes() -> Int
    func configureEpisodesCell(cell: EpisodeCellDataSourceProtocol, indexPath: IndexPath)
    func playEpisode(at indexPath: IndexPath)
}

protocol PlayListRouterProtocol {}

protocol PlayListInteractorInPutProtocol {
    var presenter: PlayListInteractorOutPutProtocol? { get set }
    var playListWorker: PlayListWorkerProtocol? { get set }
    var authWorker: AuthWorkerProtocol? { get set }
    var storage: LocalStorageProtocol? { get set }

    func login(email: String, password: String)
    func fetchPlayList()
}

protocol PlayListInteractorOutPutProtocol: AnyObject {
    func loggedInSucsessfully()
    func failedToLogin(errorMessage: String)
    func didFetchedPlayListSucsessfully(playListDetails: PlayListDetails)
    func failedToFetchPlayList(errorMessage: String)
}

protocol EpisodeCellDataSourceProtocol {
    func setData(dataSource: EpisodeCellDataSource)
}
