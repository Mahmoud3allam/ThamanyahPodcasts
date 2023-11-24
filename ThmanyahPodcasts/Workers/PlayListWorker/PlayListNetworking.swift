//
//  PlayListNetworking.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 23/11/2023.
//

import Alamofire

enum PlayListNetworking {
    case getPlayList
}

extension PlayListNetworking: APIRequestBuilder {
    var path: String {
        switch self {
        case .getPlayList:
            return "api/playlist/01GVD0TTY5RRMHH6YMCW7N1H70"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPlayList:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getPlayList:
            return .normalRequest
        }
    }
}
