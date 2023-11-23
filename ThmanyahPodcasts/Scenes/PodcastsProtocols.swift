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
}

protocol PodcastsPresenterProtocol {
    var view: PodcastsViewProtocol? { get set }

    func viewDidLoad()
}

protocol PodcastsRouterProtocol {}

protocol PodcastsInteractorInPutProtocol {
    var presenter: PodcastsInteractorOutPutProtocol? { get set }
}

protocol PodcastsInteractorOutPutProtocol: AnyObject {}
