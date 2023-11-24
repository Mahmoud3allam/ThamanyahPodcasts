//
//  PodcastsProtocols.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 23/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Foundation
protocol PodcastsViewProtocol: AnyObject {
    var presenter: PodcastsPresenterProtocol! { get set }

    func enableShimmerEffect()
    func disableShimmerEffect()
}

protocol PodcastsPresenterProtocol {
    var view: PodcastsViewProtocol? { get set }

    func login()
}

protocol PodcastsRouterProtocol {}

protocol PodcastsInteractorInPutProtocol {
    var presenter: PodcastsInteractorOutPutProtocol? { get set }

    func login(email: String, password: String)
    func fetchPodcasts()
}

protocol PodcastsInteractorOutPutProtocol: AnyObject {
    func loggedInSucsessfully()
    func failedToLogin(errorMessage: String)
    func didFetchedPodcastsSucsessfully(podcastDetails: PodcastDetails)
    func failedToFetchPodcasts(errorMessage: String)
}
