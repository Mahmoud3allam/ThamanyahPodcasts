//
//  PlayListWorker.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 23/11/2023.
//

import Foundation
protocol PlayListWorkerProtocol {
    func getPlayList(completion: @escaping (Swift.Result<PlayListResponse?, BaseAPIRequestResponseFailureErrorType>) -> Void)
}

class PlayListWorker: APIRequestExecuter<PlayListNetworking>, PlayListWorkerProtocol {
    func getPlayList(completion: @escaping (Result<PlayListResponse?, BaseAPIRequestResponseFailureErrorType>) -> Void) {
        self.performRequest(target: .getPlayList, responseClass: PlayListResponse.self) { result in
            completion(result)
        }
    }
}
