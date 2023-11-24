//
//  PlayListPresenter.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 24/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^

import Foundation
class PlayListPresenter: PlayListPresenterProtocol, PlayListInteractorOutPutProtocol {
    weak var view: PlayListViewProtocol?
    private let interactor: PlayListInteractorInPutProtocol
    private let router: PlayListRouterProtocol
    var eposidesDataSource = [EposideCellDataSource]()
    var playListSectionHeaderDataSource: PlayListSectionHeaderDataSource?
    var didFetchedPlayList: Bool = false

    init(view: PlayListViewProtocol, interactor: PlayListInteractorInPutProtocol, router: PlayListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func login() {
        self.view?.showLoading()
        self.interactor.login(email: "ajbusaleh@gmail.com",
                              password: "123123aJ*")
    }

    func numberOfEposides() -> Int {
        return eposidesDataSource.count > 0 ? eposidesDataSource.count : 10
    }

    func configureEposidesCell(cell: EposideCellDataSourceProtocol, indexPath: IndexPath) {
        guard indexPath.item <= self.eposidesDataSource.count - 1 else {
            return
        }
        cell.setData(dataSource: self.eposidesDataSource[indexPath.item])
    }

    func loggedInSucsessfully() {
        self.interactor.fetchPlayList()
    }

    func failedToLogin(errorMessage _: String) {
        // Handle Failure
        self.view?.hideLoading()
    }

    func didFetchedPlayListSucsessfully(playListDetails: PlayListDetails) {
        if let eposides = playListDetails.episodes {
            self.eposidesDataSource = eposides.map { eposide in
                EposideCellDataSource(imageUrl: eposide.image, audioUrl: eposide.audioLink, title: eposide.name, name: eposide.podcastName, date: eposide.releaseDate)
            }
        }
        if let playList = playListDetails.playlist {
            let playListDataSource = PlaylistDataSource(playlistImageUrl: playList.image ?? "",
                                                        playlistTitle: playList.name ?? "",
                                                        playListDescription: playList.description ?? "")
            self.view?.setPlaylistHeaderData(dataSource: playListDataSource)

            self.playListSectionHeaderDataSource = PlayListSectionHeaderDataSource(count: playList.episodeCount, totalSeconds: playList.episodeTotalDuration)
        } else {}
        self.didFetchedPlayList = true
        self.view?.hideLoading()
        self.view?.reloadTableView()
    }

    func failedToFetchPlayList(errorMessage _: String) {
        self.view?.hideLoading()
    }
}
