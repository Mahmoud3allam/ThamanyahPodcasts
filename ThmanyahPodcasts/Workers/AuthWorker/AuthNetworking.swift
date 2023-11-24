//
//  AuthNetworking.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 23/11/2023.
//

import Alamofire
import Foundation
enum AuthNetworking {
    case login(email: String, password: String)
}

extension AuthNetworking: APIRequestBuilder {
    var path: String {
        switch self {
        case .login:
            return "api/auth/login"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .login(email, password):
            return .WithParametersRequest(parameters: ["email": email,
                                                       "password": password],
                                          encoding: JSONEncoding.default)
        }
    }
}
