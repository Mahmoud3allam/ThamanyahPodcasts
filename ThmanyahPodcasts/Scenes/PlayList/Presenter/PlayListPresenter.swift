//
//  PlayListPresenter.swift
//  ThmanyahPodcasts
//
//  Created Mahmoud Allam on 24/11/2023.
//  Copyright © 2023 https://github.com/Mahmoud3allam. All rights reserved.
//
// @Mahmoud Allam Templete ^_^

import Foundation
class PlayListPresenter: PlayListPresenterProtocol {
    weak var view: PlayListViewProtocol?
    private let interactor: PlayListInteractorInPutProtocol
    private let router: PlayListRouterProtocol
    var EpisodesDataSource = [EpisodeCellDataSource]()
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

    func numberOfEpisodes() -> Int {
        return EpisodesDataSource.count > 0 ? EpisodesDataSource.count : 10
    }

    func configureEpisodesCell(cell: EpisodeCellDataSourceProtocol, indexPath: IndexPath) {
        guard indexPath.item <= self.EpisodesDataSource.count - 1 else {
            return
        }
        cell.setData(dataSource: self.EpisodesDataSource[indexPath.item])
    }

    func playEpisode(at indexPath: IndexPath) {
        guard let episode = EpisodesDataSource[safe: indexPath.item] else {
            return
        }

        let playerDataSource = PodcastPlayer.Presentable(
            podcastId: episode.id ?? "",
            podcastUrl: episode.audioUrl ?? "",
            podCastTitle: episode.title ?? "",
            podCastAuther: episode.name ?? "",
            pocCastImage: .url(episode.imageUrl ?? "")
        )

        view?.playEpisode(dataSource: playerDataSource)
        view?.selectRow(at: indexPath)
    }
}

extension PlayListPresenter: PlayListInteractorOutPutProtocol {
    func loggedInSucsessfully() {
        self.interactor.fetchPlayList()
    }

    func failedToLogin(errorMessage _: String) {
        // Handle Failure
        self.view?.hideLoading()
    }

    func didFetchedPlayListSucsessfully(playListDetails: PlayListDetails) {
        if let Episodes = playListDetails.episodes {
            self.EpisodesDataSource = Episodes.map { Episode in
                EpisodeCellDataSource(id: Episode.id,
                                      imageUrl: Episode.image,
                                      audioUrl: Episode.audioLink,
                                      title: Episode.name,
                                      name: Episode.podcastName,
                                      date: Episode.createdAt,
                                      totalSeconds: Episode.durationInSeconds)
            }
        }
        if let playList = playListDetails.playlist {
            let playListDataSource = PlaylistDataSource(playlistImageUrl: playList.image ?? "",
                                                        playlistTitle: playList.name ?? "",
                                                        playListDescription: playList.description ?? "")
            self.view?.setPlaylistHeaderData(dataSource: playListDataSource)

            self.playListSectionHeaderDataSource = PlayListSectionHeaderDataSource(count: playList.episodeCount,
                                                                                   totalSeconds: playList.episodeTotalDuration)
        }
        self.didFetchedPlayList = true
        self.view?.hideLoading()
        self.view?.reloadTableView()
    }

    func failedToFetchPlayList(errorMessage _: String) {
        self.view?.hideLoading()
    }
}
