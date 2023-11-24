//
//  PodcastsPresenter.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 23/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^

import Foundation
class PodcastsPresenter: PodcastsPresenterProtocol {
    weak var view: PodcastsViewProtocol?
    private let interactor: PodcastsInteractorInPutProtocol
    private let router: PodcastsRouterProtocol

    init(view: PodcastsViewProtocol, interactor: PodcastsInteractorInPutProtocol, router: PodcastsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func login() {
        self.view?.enableShimmerEffect()
        self.interactor.login(email: "ajbusaleh@gmail.com",
                              password: "123123aJ*")
    }
}

extension PodcastsPresenter: PodcastsInteractorOutPutProtocol {
    func loggedInSucsessfully() {
        self.interactor.fetchPodcasts()
    }

    func failedToLogin(errorMessage _: String) {
        // Handle Failure
        self.view?.disableShimmerEffect()
    }

    func didFetchedPodcastsSucsessfully(podcastDetails _: PodcastDetails) {
        self.view?.disableShimmerEffect()
    }

    func failedToFetchPodcasts(errorMessage _: String) {
        self.view?.disableShimmerEffect()
    }
}
