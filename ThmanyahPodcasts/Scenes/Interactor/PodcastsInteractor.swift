//
//  PodcastsInteractor.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 23/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Foundation
class PodcastsInteractor: PodcastsInteractorInPutProtocol {
    weak var presenter: PodcastsInteractorOutPutProtocol?
    var authWorker: AuthWorker?
    var podcastWorker: PodcastWorker?
    var storage: LocalStorageProtocol?

    func login(email: String, password: String) {
        authWorker?.login(email, password, completion: { result in
            switch result {
            case let .success(user):
                guard let user = user else {
                    self.presenter?.failedToLogin(errorMessage: BaseAPIRequestResponseBusinessErrorType.somethingWentWrong.message.localize)
                    return
                }
                self.storage?.write(key: UserDefaultsKeys.accessToken, value: user.accessToken)
                self.presenter?.loggedInSucsessfully()
            case let .failure(error):
                self.presenter?.failedToLogin(errorMessage: error.message.localize)
            }
        })
    }

    func fetchPodcasts() {
        self.podcastWorker?.getPodcasts(completion: { result in
            switch result {
            case let .success(podcastResponse):
                guard let podcastDetails = podcastResponse?.data else {
                    self.presenter?.failedToFetchPodcasts(errorMessage: BaseAPIRequestResponseBusinessErrorType.somethingWentWrong.message.localize)
                    return
                }
                self.presenter?.didFetchedPodcastsSucsessfully(podcastDetails: podcastDetails)
            case let .failure(error):
                self.presenter?.failedToFetchPodcasts(errorMessage: error.message.localize)
            }
        })
    }
}
