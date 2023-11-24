//
//  PlayListRouter.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 24/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import UIKit
class PlayListRouter: PlayListRouterProtocol {
    weak var viewController: UIViewController?

    static func createAnModule() -> UIViewController {
        let interactor = PlayListInteractor()
        let router = PlayListRouter()
        let view = PlayListViewController()
        let presenter = PlayListPresenter(view: view, interactor: interactor, router: router)
        let authWorker = AuthWorker()
        let podcastWorker = PlayListWorker()
        let storage = UserDefaultManager()
        view.presenter = presenter
        router.viewController = view
        interactor.presenter = presenter
        interactor.authWorker = authWorker
        interactor.storage = storage
        interactor.playListWorker = podcastWorker
        return view
    }
}
