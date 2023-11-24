//
//  PodcastNetworking.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 23/11/2023.
//

import Alamofire

enum PodcastNetworking {
    case getPodcasts
}

extension PodcastNetworking: APIRequestBuilder {
    var path: String {
        switch self {
        case .getPodcasts:
            return "api/playlist/01GVD0TTY5RRMHH6YMCW7N1H70"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPodcasts:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getPodcasts:
            return .normalRequest
        }
    }
}
