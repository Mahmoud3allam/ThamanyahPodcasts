//
//  PlayListInteractor.swift
//  ThmanyahPodcasts
//
//  Created Mahmoud Allam on 24/11/2023.
//  Copyright © 2023 https://github.com/Mahmoud3allam. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Foundation
class PlayListInteractor: PlayListInteractorInPutProtocol {
    weak var presenter: PlayListInteractorOutPutProtocol?
    var authWorker: AuthWorkerProtocol?
    var playListWorker: PlayListWorkerProtocol?
    var storage: LocalStorageProtocol?

    func login(email: String, password: String) {
        authWorker?.login(email, password, completion: { [weak self] result in
            guard let self = self else {
                return
            }
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

    func fetchPlayList() {
        self.playListWorker?.getPlayList(completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(playListResponse):
                guard let playListDetails = playListResponse?.data else {
                    self.presenter?.failedToFetchPlayList(errorMessage: BaseAPIRequestResponseBusinessErrorType.somethingWentWrong.message.localize)
                    return
                }
                self.presenter?.didFetchedPlayListSucsessfully(playListDetails: playListDetails)
            case let .failure(error):
                self.presenter?.failedToFetchPlayList(errorMessage: error.message.localize)
            }
        })
    }
}
