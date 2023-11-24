//
//  PodcastsRouter.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 23/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import UIKit
class PodcastsRouter: PodcastsRouterProtocol {
    weak var viewController: UIViewController?

    static func createAnModule() -> UIViewController {
        let interactor = PodcastsInteractor()
        let router = PodcastsRouter()
        let view = PodcastsViewController()
        let presenter = PodcastsPresenter(view: view, interactor: interactor, router: router)
        let authWorker = AuthWorker()
        let podcastWorker = PodcastWorker()
        let storage = UserDefaultManager()
        view.presenter = presenter
        router.viewController = view
        interactor.presenter = presenter
        interactor.authWorker = authWorker
        interactor.storage = storage
        interactor.podcastWorker = podcastWorker
        return view
    }
}
