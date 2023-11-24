//
//  AuthWorker.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 23/11/2023.
//

import Foundation

protocol AuthWorkerProtocol {
    func login(_ email: String, _ password: String, completion: @escaping (Swift.Result<UserResponse?, BaseAPIRequestResponseFailureErrorType>) -> Void)
}

class AuthWorker: APIRequestExecuter<AuthNetworking>, AuthWorkerProtocol {
    func login(_ email: String, _ password: String, completion: @escaping (Result<UserResponse?, BaseAPIRequestResponseFailureErrorType>) -> Void) {
        self.performRequest(target: .login(email: email, password: password), responseClass: UserResponse.self) { result in
            completion(result)
        }
    }
}
