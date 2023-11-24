//
//  PodcastWorker.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 23/11/2023.
//

import Foundation
protocol PodcastWorkerProtocol {
    func getPodcasts(completion: @escaping (Swift.Result<PodcastResponse?, BaseAPIRequestResponseFailureErrorType>) -> Void)
}

class PodcastWorker: APIRequestExecuter<PodcastNetworking>, PodcastWorkerProtocol {
    func getPodcasts(completion: @escaping (Result<PodcastResponse?, BaseAPIRequestResponseFailureErrorType>) -> Void) {
        self.performRequest(target: .getPodcasts, responseClass: PodcastResponse.self) { result in
            completion(result)
        }
    }
}
