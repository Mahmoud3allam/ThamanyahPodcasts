//
//  PlayListInteractor.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 24/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Foundation
class PlayListInteractor: PlayListInteractorInPutProtocol {
    weak var presenter: PlayListInteractorOutPutProtocol?

    var authWorker: AuthWorker?
    var playListWorker: PlayListWorker?
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

    func fetchPlayList() {
        self.playListWorker?.getPlayList(completion: { result in
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
