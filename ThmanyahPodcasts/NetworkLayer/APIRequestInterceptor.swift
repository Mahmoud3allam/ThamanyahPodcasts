//
//  APIRequestInterceptor.swift
//  ThmanyahPodcasts
//
//  Created Mahmoud Allam on 23/11/2023.
//  Copyright © 2023 https://github.com/Mahmoud3allam. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Alamofire
import Foundation

final class APIRequestInterceptor: RequestInterceptor {
    private let userDefaultsManager: LocalStorageProtocol = UserDefaultManager()

    var accessToken: String {
        userDefaultsManager.value(key: UserDefaultsKeys.accessToken) ?? ""
    }

    func adapt(_ urlRequest: URLRequest, for _: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if !accessToken.isEmpty {
            urlRequest.headers.add(.authorization(bearerToken: accessToken))
        }
        completion(.success(urlRequest))
    }
}
