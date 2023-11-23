//
//  PodcastsPresenter.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 23/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^

import Foundation
class PodcastsPresenter: PodcastsPresenterProtocol, PodcastsInteractorOutPutProtocol {
    weak var view: PodcastsViewProtocol?
    private let interactor: PodcastsInteractorInPutProtocol
    private let router: PodcastsRouterProtocol

    init(view: PodcastsViewProtocol, interactor: PodcastsInteractorInPutProtocol, router: PodcastsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        print("ViewDidLoad")
    }
}
